import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/model/bank_hot.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/utils/get_phone_message.dart';
import 'package:the_fish_fly/widget/web_view.dart';

import '../login_page.dart';

class BankCardQueries extends StatefulWidget {
  final List<BankHotData> bankHotList;

  const BankCardQueries(
    this.bankHotList, {
    Key key,
  }) : super(key: key);

  @override
  _BankCardQueriesState createState() => new _BankCardQueriesState();
}

class _BankCardQueriesState extends State<BankCardQueries> {
  double _widgetHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _widgetHeight = 95.0 * (widget.bankHotList.length / 3) + 90.0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: PhoneMessage.statusBarHeight,
            ),
          ),
          _appBar(),
          _widget()
        ],
      ),
    );
  }
  Widget _appBar() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: ColorUtils.appWhiteColor,
            padding: EdgeInsets.all(20),
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorUtils.appMain2TextColor,
              size: 18,
            ),
          ),
        ),
        Expanded(
          child: Container(),
          flex: 1,
        ),
        Text(
          '进度查询',
          style: TextStyle(color: ColorUtils.appMain2TextColor, fontSize: 18),
        ),
        Expanded(
          child: Container(),
          flex: 1,
        ),
        Container(
            padding: EdgeInsets.all(20),
            child: Container()
        ),
      ],
    );
  }

  Widget _widget() {
    if (widget.bankHotList == null) return null;
    List<Widget> items = new List<Widget>();
    widget.bankHotList.forEach((mode) {
      items.add(_view(context, mode));
    });
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: _widgetHeight,
          child: GridView.count(
              padding: const EdgeInsets.only(top: 20.0),
              crossAxisCount: 3,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 20.0,
              childAspectRatio: 2 / 1.3,
              //主轴间隔
              children: items),
        ),
      ],
    );
  }

  Widget _view(BuildContext context, BankHotData mode) {
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
                  title: mode.name,
                )));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            mode.img,
            width: 36,
            height: 36,
          ),
          Padding(
            padding: EdgeInsets.only(top: 4),
          ),
          Text(mode.name,
              style:
                  TextStyle(color: ColorUtils.appMain2TextColor, fontSize: 14)),
          Text(
            mode.welfare,
            style: TextStyle(
                color: ColorUtils.appTopAdvertisingTextColor, fontSize: 10),
          )
        ],
      ),
    );
  }
}
