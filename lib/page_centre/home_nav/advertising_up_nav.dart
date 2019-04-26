import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/model/advertising_model.dart';
import 'package:the_fish_fly/page_centre/home_nav/advertising_nav.dart';
import 'package:the_fish_fly/page_centre/login_page.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/widget/web_view.dart';

class AdvertisingUpNav extends StatelessWidget {
  final List<AdvertisingGoodsModel> advertisingNavList;

  const AdvertisingUpNav({Key key, this.advertisingNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
        itemCount:advertisingNavList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int indext) {
          return AdvertisingNav(advertisingNavList: advertisingNavList,);
        },
        viewportFraction: 0.9,
        scale: 0.95,
        pagination: SwiperPagination())
    ;
  }

}
