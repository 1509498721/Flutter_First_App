import 'package:flutter/cupertino.dart';
import 'package:the_fish_fly/model/bank_advertising.dart';
import 'package:the_fish_fly/utils/color_utils.dart';

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
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: items,
      ),
    );
  }

  Widget _view(BuildContext context, BankAdvertisingData mode) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: Column(
        children: <Widget>[Image.network(mode.img,width: 108,height: 64,),
          Padding(padding: EdgeInsets.only(top: 2),),
          Text(mode.title,style: TextStyle(color: ColorUtils.appMain2TextColor,
              fontSize: 14),),
          Padding(padding: EdgeInsets.only(top: 2),),
          Text(mode.info,style: TextStyle(color: ColorUtils.appTopAdvertisingTextColor,
              fontSize: 10))],
      ),
    );
  }
}
