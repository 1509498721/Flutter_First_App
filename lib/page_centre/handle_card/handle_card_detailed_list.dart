import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/model/bank_detailed.dart';
import 'package:the_fish_fly/model/bank_main_show.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/widget/web_view.dart';

import '../login_page.dart';

class DetailedListNav extends StatelessWidget {
  final List<BankDetailedRows> bankDetailedList;

  const DetailedListNav(
    this.bankDetailedList, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widget(bankDetailedList, context),
    );
  }
}

Widget _widget(List<BankDetailedRows> bankDetailedList, BuildContext context) {
  if (bankDetailedList == null) return null;
  List<Widget> items = new List<Widget>();
  bankDetailedList.forEach((mode) {
    items.add(_view(context, mode));
  });
  return Column(
    children: items,
  );
}

Widget _view(BuildContext context, BankDetailedRows mode) {
  return Container(
    child: GestureDetector(
      onTap: () {
        CommonCode.My_TOKENTInfo == null
            ? Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => LoginPage()),
              )
            : Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => WebView(
                          url: mode.shorturl,
                          title: mode.title,
                        )));
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          color: ColorUtils.appWhiteColor,
          height: 70,
          child: Row(
            children: <Widget>[
              Image.network(
                mode.img,
                width: 102,
              ),
              Container(
                padding: EdgeInsets.only(left: 16, top: 2, bottom: 8),
                width: 210,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        mode.title,
                        style: TextStyle(
                            color: ColorUtils.appMain2TextColor, fontSize: 14),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Text(
                        mode.info,
                        style: TextStyle(
                            color: ColorUtils.appTopAdvertisingTextColor,
                            fontSize: 10),
                      ),
                      flex: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _image(mode.tagid),
                        Text(mode.uv.toString() + "人已申请",
                            style: TextStyle(
                                color: ColorUtils.appTopAdvertisingTextColor,
                                fontSize: 12))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

_image(int pos) {
  switch (pos) {
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
