import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_fish_fly/model/classification_model.dart';
import 'package:the_fish_fly/page_centre/home_nav/screen/screen_top_1_nav.dart';
import 'package:the_fish_fly/page_centre/home_nav/screen/screen_top_2_nav.dart';
import 'package:the_fish_fly/page_centre/home_nav/screen/screen_top_3_nav.dart';
import 'package:the_fish_fly/page_centre/home_nav/screen/screen_top_4_nav.dart';
import 'package:the_fish_fly/utils/color_utils.dart';

class LocalNav extends StatelessWidget {
  final List<ClassificationPropertyModel> localNavList;

  const LocalNav({Key key, this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 26, right: 26, top: 16),
        child: _items(context),
      ),
    );
  }

//创建分类大视图
  _items(BuildContext context) {
    if (localNavList == null) return null;
    List<Widget> items = [];
    localNavList.forEach((mode) {
      items.add(_item(context, mode));
    });
    return Row(
      //平均排列
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  //赋值以及创建具体视图
  Widget _item(BuildContext context, ClassificationPropertyModel model) {
    return GestureDetector(
      onTap: () {
        if(model.id==1){
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => ScreenTop1Nav()),
          );
        }else if(model.id==2){
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => ScreenTop2Nav()),
          );
        }else if(model.id==3){
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => ScreenTop3Nav()),
          );
        }else if(model.id==4){
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => ScreenTop4Nav()),
          );
        }else{

        }
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.img,
            width: 36,
            height: 36,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              model.title,
              style:
              TextStyle(color: ColorUtils.appMain2TextColor, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
