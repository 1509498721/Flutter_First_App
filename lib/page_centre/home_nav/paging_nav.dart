import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/model/paging_model.dart';
import 'package:the_fish_fly/page_centre/login_page.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/widget/web_view.dart';

class PagingNav extends StatelessWidget {
  final List<PagingRowModel> pagingRowNavList;

  const PagingNav({Key key, this.pagingRowNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: _items(context),
      ),
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
      //平均排列
      children: items,
    );
  }

  //赋值以及创建具体视图
  Widget _item(BuildContext context, PagingRowModel model) {
    return Container(
      padding: EdgeInsets.only(top: 16),
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
                                model.goodsSource +
                                "?id=" +
                                CommonCode.USER_IDInfo +
                                "&frendSource=" +
                                CommonCode.USER_SOURCEInfo,
                            title: model.title,
                          )));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: ColorUtils.appWhiteColor,
              boxShadow: [
                BoxShadow(
                    color: ColorUtils.gradientEnd13Color,
                    offset: Offset(3.0, 3.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0)
              ]),
          padding: EdgeInsets.only(right: 16),
          child: Container(
            decoration: BoxDecoration(color: ColorUtils.appWhiteColor),
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
                                height: 20,
                              ),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                model.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
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
                                  color: ColorUtils.appTopAdvertisingTextColor,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              _getComma(model.limit),
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorUtils.appHomeAdvertisingColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Expanded(
                              child: Container(),
                              flex: 1,
                            ),
                            Text(
                              "月利率" + model.interestrate + "%",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "|",
                              style: TextStyle(
                                  color: ColorUtils.appHomePagingGangColor),
                            ),
                            Text(
                              "期限" + model.deadline + "个月",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
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
                        padding: EdgeInsets.only(top: 8),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '最高额度',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: ColorUtils.appTopAdvertisingTextColor),
                            ),
                            Expanded(
                              child: Container(),
                              flex: 1,
                            ),
                            Text(
                              _getDetails(model.details),
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorUtils.appTopAdvertisingTextColor,
                              ),
                            ),
                            Expanded(
                              child: Container(),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
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
      ),
    );
  }

  _image(PagingRowModel model) {
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
      return details.substring(0, 15);
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
          ",  " +
          limit.substring(stringSige - 3, stringSige);
    } else if (stringSige < 10) {
      return limit.substring(0, stringSige - 3) +
          ",  " +
          limit.substring(3, 6) +
          ",  " +
          limit.substring(stringSige - 3, stringSige);
    } else {
      return limit;
    }
  }
}
