import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_fish_fly/model/bank_hot.dart';
import 'package:the_fish_fly/utils/color_utils.dart';

import 'handle_card_detailed.dart';

class BankHotNav extends StatefulWidget {
  final List<BankHotData> bankHotList;

  const BankHotNav(
    this.bankHotList, {
    Key key,
  }) : super(key: key);

  @override
  _BankHotState createState() => new _BankHotState();
}

class _BankHotState extends State<BankHotNav> {
  double _widgetHeight = 200.0;
  bool _look = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _widget(),
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
        GestureDetector(
          onTap: () {
            if (_look) {
              _look = false;
              _widgetHeight = 200.0;
            } else {
              _look = true;
              _widgetHeight = 90.0 * (widget.bankHotList.length / 3) + 90.0;
            }
            setState(() {});
          },
          child: Container(
            color: ColorUtils.appWhiteColor,
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Text(
                  _look ? '收起更多' : '查看更多',
                  style: TextStyle(
                      color: ColorUtils.appTopAdvertisingTextColor,
                      fontSize: 12),
                ),
                Icon(
                  _look ? Icons.expand_less : Icons.expand_more,
                  color: ColorUtils.appTopAdvertisingTextColor,
                  size: 18,
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _view(BuildContext context, BankHotData mode) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => BankCardDetailed(
                      bankId: mode.id,
                      bankName: mode.name,
                      bankImage: mode.img,
                      bankHint: mode.welfare,
                      bankSpeed: mode.speed,
                      bankThrough: mode.passrate,
                      bankLines: mode.banklimit,
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
