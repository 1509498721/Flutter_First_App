import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/model/bank_advertising.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/widget/web_view.dart';

import '../login_page.dart';

class BankAdvertisingNav extends StatefulWidget {
  final List<BankAdvertisingData> bankAdvertisingList;

  const BankAdvertisingNav(
    this.bankAdvertisingList, {
    Key key,
  }) : super(key: key);

  @override
  _BankAdvertisingState createState() => new _BankAdvertisingState();
}

class _BankAdvertisingState extends State<BankAdvertisingNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widget(),
    );
  }

  Widget _widget() {
    if (widget.bankAdvertisingList == null) return null;
    List<Widget> items = new List<Widget>();
    widget.bankAdvertisingList.forEach((mode) {
      items.add(_view(context, mode));
    });
    return Container(
      width: double.infinity,
      height: 116,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: items,
      ),
    );
  }

  Widget _view(BuildContext context, BankAdvertisingData mode) {
    return GestureDetector(
      onTap: () {
        CommonCode.My_TOKENTInfo == null
            ? Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => LoginPage()),
        ) : Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => WebView(
                      url: mode.shorturl,
                      title: mode.title,
                    )));
      },
      child: Padding(
        padding: EdgeInsets.only(right: 16),
        child: Column(
          children: <Widget>[
            Image.network(
              mode.img,
              width: 108,
              height: 64,
            ),
            Padding(
              padding: EdgeInsets.only(top: 2),
            ),
            Text(
              mode.title,
              style:
                  TextStyle(color: ColorUtils.appMain2TextColor, fontSize: 14),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2),
            ),
            Text(mode.info,
                style: TextStyle(
                    color: ColorUtils.appTopAdvertisingTextColor, fontSize: 10))
          ],
        ),
      ),
    );
  }
}
