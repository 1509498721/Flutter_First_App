import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/model/advertising_model.dart';
import 'package:the_fish_fly/page_centre/login_page.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/widget/web_view.dart';

class AdvertisingNav extends StatelessWidget {
  final List<AdvertisingGoodsModel> advertisingNavList;

  const AdvertisingNav({Key key, this.advertisingNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 5),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: ColorUtils.gradientEnd13Color,
              offset: Offset(3.0, 3.0),
              blurRadius: 5.0,
              spreadRadius: 1.0)
        ]),
        child: _views(context),
      )
    ],);
  }

  _views(BuildContext context) {
    if (advertisingNavList == null) return null;
    Widget items;
    advertisingNavList.forEach((mode) {
      items = _view(context, mode);
    });
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ColorUtils.appWhiteColor),
      child: items,
    );
  }

  Widget _view(BuildContext context, AdvertisingGoodsModel mode) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, top: 6, right: 16, bottom: 6),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  child: Image.network(
                    mode.img,
                    height: 24,
                  ),
                  borderRadius: BorderRadius.circular(2.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    mode.title,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Text(
                  mode.uv.toString() + "人申请",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: ColorUtils.appTopAdvertisingTextColor,
                      fontSize: 12),
                ),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      '最高额度(元）',
                      style: TextStyle(
                          color: ColorUtils.appTopAdvertisingTextColor,
                          fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      _getComma(mode.limit),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ColorUtils.appTopAdvertisingMainTextColor,
                          fontSize: 32),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 64, left: 64, top: 8),
                    child: GestureDetector(
                      onTap: () {

                        CommonCode.My_TOKENTInfo == null
                            ? Navigator.push(
                          context,
                          new MaterialPageRoute(builder: (context) => LoginPage()),
                        )
                            : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebView(
                                  url: CommonCode.BASE_URL +
                                      'Supermarke/' +
                                      mode.goodsSource +
                                      "?id=" +
                                      CommonCode.USER_IDInfo +
                                      "&frendSource=" +
                                      CommonCode.USER_SOURCEInfo,
                                  title: mode.title,
                                )));

                      },
                      child: Container(
                        height: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                colors: [
                                  ColorUtils.gradientStartColor,
                                  ColorUtils.gradientEndColor
                                ],
                                begin: FractionalOffset(1, 0),
                                end: FractionalOffset(0, 1))),
                        child: Center(
                          child: Text(
                            "只需三步,立即拿钱",
                            style: TextStyle(
                                color: ColorUtils.appWhiteColor, fontSize: 12,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12),
                  )
                ],
              ),
              Align(
                  alignment: FractionalOffset.centerRight,
                  child: Image.asset(
                    'images/index_view_topright_new.png',
                  )),
            ],
          )
        ],
      ),
    );
  }

  String _getComma(String limit) {
    var stringSige = limit.length;
    if (stringSige < 4) {
      return limit;
    } else if (stringSige < 7) {
      return limit.substring(0, stringSige - 3) +
          ", " +
          limit.substring(stringSige - 3, stringSige);
    } else if (stringSige < 10) {
      return limit.substring(0, stringSige - 3) +
          ", " +
          limit.substring(3, 6) +
          ", " +
          limit.substring(stringSige - 3, stringSige);
    } else {
      return limit;
    }
  }
}
