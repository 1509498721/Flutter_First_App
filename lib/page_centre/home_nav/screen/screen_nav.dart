import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_fish_fly/model/home_screen_model.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/widget/web_view.dart';
class ScreenNav extends StatelessWidget {
  final List<HomeScreem> pagingRowNavList;

  const ScreenNav({Key key, this.pagingRowNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _items(context),
    );
  }

//创建分类大视图
  _items(BuildContext context) {
    if (pagingRowNavList == null) return null;
    List<Widget> items = [];
    pagingRowNavList.forEach((mode) {
      items.add(_item(context, mode));
    });
    return Column(
      children: items,
    );
  }

  //赋值以及创建具体视图
  Widget _item(BuildContext context, HomeScreem model) {
    return Container(
      padding: EdgeInsets.only(top: 14),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(
                        url: model.shortUrl,
                        title: model.title,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
              color: ColorUtils.appTabNavigator,
              borderRadius: BorderRadius.circular(4)),
          padding: EdgeInsets.only(right: 16),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            child: Image.network(
                              model.img,
                              height: 24,
                            ),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              model.title,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ColorUtils.appWhiteColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: _image(model),
                          ),
                          Expanded(
                            child: Container(),
                            flex: 1,
                          ),
                          Text(
                            model.uv.toString() + "人申请",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: ColorUtils.appHomeMoreColor,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Row(
                        children: <Widget>[
                          Text(
                            _getComma(model.limit),
                            style: TextStyle(
                                fontSize: 14,
                                color: ColorUtils.appHomeAdvertisingColor),
                          ),
                          Expanded(
                            child: Container(),
                            flex: 1,
                          ),
                          Text(
                            "月" + model.interestrate + "%",
                            style: TextStyle(
                                fontSize: 14,
                                color: ColorUtils.appMain2TextColor),
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                                color: ColorUtils.appHomePagingGangColor),
                          ),
                          Text(
                            model.deadline + "个月",
                            style: TextStyle(
                                fontSize: 14,
                                color: ColorUtils.appMain2TextColor),
                          ),
                          Expanded(
                            child: Container(),
                            flex: 1,
                          ),
                          Image.asset('images/item_right_new.png')
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '最高额度',
                            style: TextStyle(
                                color: ColorUtils.appHomePagingTextColor),
                          ),
                          Expanded(
                            child: Container(),
                            flex: 1,
                          ),
                          Text(
                            _getDetails(model.details),
                            style: TextStyle(
                                color: ColorUtils.appHomePagingTextColor),
                          ),
                          Expanded(
                            child: Container(),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                    )
                  ],
                ),
              ),
              Align(
                alignment: FractionalOffset.centerLeft,
                child: Image.asset('images/im_paging_rig.png',
                    fit: BoxFit.fitHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _image(HomeScreem model) {
    switch (model.tagId) {
      case 1:
        {
          return Image.asset('images/item_title_1_new.png');
        }
      case 2:
        {
          return Image.asset('images/item_title_2.png');
        }
      case 3:
        {
          return Image.asset('images/item_title_3_new.png');
        }
      default:
        {
          return Image.asset('images/item_title_1_new.png');
        }
    }
  }

  String _getDetails(String details) {
    try {
      return details.substring(0, 12);
    } catch (e) {
      return details;
    }
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
