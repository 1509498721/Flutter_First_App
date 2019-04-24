import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_fish_fly/model/advertising_model.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/widget/web_view.dart';

class AdvertisingNav extends StatelessWidget {
  final List<AdvertisingGoodsModel> advertisingNavList;

  const AdvertisingNav({Key key, this.advertisingNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: _views(context),
    );
  }

  _views(BuildContext context) {
    if (advertisingNavList == null) return null;
    Widget items;
    advertisingNavList.forEach((mode) {
      items = _view(context, mode);
    });
    return Container(
      decoration: BoxDecoration(
          color: ColorUtils.appTabNavigator,
          borderRadius: BorderRadius.circular(4)),
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
                    style: TextStyle(
                        color: ColorUtils.appMain2TextColor, fontSize: 14),
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
                      color: ColorUtils.appMain2TextColor, fontSize: 14),
                ),
              ],
            ),
          ),
          Container(
            color: ColorUtils.appMainFragmentBacColor,
            height: 1,
          ),
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      '最高额度(元）',
                      style: TextStyle(
                          color: ColorUtils.appMain2TextColor, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      _getComma(mode.limit),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ColorUtils.appWhiteColor,
                          fontSize: 36),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 12, left: 24, right: 24),
                    height: 38,
                    //充满
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebView(
                                      url: mode.shortUrl,
                                      title: mode.title,
                                    )));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      color: ColorUtils.appHomeAdvertisingColor,
                      child: Text(
                        "立即申请",
                        style: TextStyle(
                            color: ColorUtils.appWhiteColor, fontSize: 14),
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
                    height: 55,
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
