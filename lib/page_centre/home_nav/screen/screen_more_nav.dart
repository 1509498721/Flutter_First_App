import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:the_fish_fly/model/home_screen_model.dart';
import 'package:the_fish_fly/model/screen_model.dart';
import 'package:the_fish_fly/page_centre/home_nav/screen/screen_nav.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/utils/get_phone_message.dart';

class ScreenMoreNav extends StatefulWidget {
  @override
  _ScreenMoreNavState createState() => _ScreenMoreNavState();
}

class _ScreenMoreNavState extends State<ScreenMoreNav> {
  //刷新总样式
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  //金钱
  List<ScreenCashAmount> _screenCashAmount;

  //时间
  List<ScreenDeadLine> _screenDeadLine;

  //列表
  List<ScreenCompositeRank> _screenCompositeRank;

  //原数据
  List<HomeScreem> _homeScreem;

  //更新之后的数据
  List<HomeScreem> _homeScreemup;
  String _string = 'money';

  bool _money = false;
  bool _date = false;
  bool _sort = false;
  String _moneyText = '金额';
  String _dateText = '贷款期限';
  String _sortText = '综合排序';
  bool _isShowItem = false;

  @override
  void initState() {
    super.initState();
    _screenCashAmount = CommonCode.screenModel.cashAmount;
    _screenCompositeRank = CommonCode.screenModel.compositeRank;
    _screenDeadLine = CommonCode.screenModel.deadLine;
    _homeScreem = CommonCode.homeScreem;
    _homeScreemup = _homeScreem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtils.appWhiteColor,
        body: EasyRefresh(
          key: _easyRefreshKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: PhoneMessage.statusBarHeight,
                  right: 44,
                ),
                child: Column(
                  children: <Widget>[_appBar()],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: ColorUtils.appWhiteColor,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                          color: ColorUtils.gradientEnd13Color,
                          offset: Offset(3.0, 3.0),
                          blurRadius: 10.0,
                          spreadRadius: 3.0)
                    ]),
                child: Padding(
                  padding: EdgeInsets.only(right: 24, left: 24),
                  child: _screenType(),
                ),
              ),
              Offstage(
                offstage: _isShowItem ? true : false,
                child: ScreenNav(
                  pagingRowNavList: _homeScreemup,
                ),
              ),
              Offstage(
                offstage: _isShowItem ? false : true,
                child: Container(
                  color: ColorUtils.gradientEnd13Color,
                  child: Column(
                    children: _items(_string),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _itemMoney(ScreenCashAmount mode) {
    return GestureDetector(
      onTap: () {
        _money = false;
        _isShowItem = false;
        _upDadaMoney(mode.moneyname);
        setState(() {});
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              mode.moneyname,
              style:
                  TextStyle(color: ColorUtils.appMain2TextColor, fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemSort(ScreenCompositeRank mode) {
    return GestureDetector(
      onTap: () {
        _sort = false;
        _isShowItem = false;
        _upDadaSort(mode.title);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Center(
          child: Text(
            mode.title,
            style: TextStyle(color: ColorUtils.appMain2TextColor, fontSize: 13),
          ),
        ),
      ),
    );
  }

  Widget _itemDate(ScreenDeadLine mode) {
    return GestureDetector(
      onTap: () {
        _date = false;
        _isShowItem = false;
        _upDadaDate(mode.term);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Center(
          child: Text(
            mode.term,
            style: TextStyle(color: ColorUtils.appMain2TextColor, fontSize: 13),
          ),
        ),
      ),
    );
  }

  _upDadaSort(String conditions) {
    List<HomeScreem> _list = new List<HomeScreem>();
    if (conditions == '新户专享') {
      _homeScreem.forEach((mode) {
        if (mode.propertyIds == '1') {
          _list.add(mode);
        }
      });
    } else if (conditions == '贷款超市') {
      _homeScreem.forEach((mode) {
        if (mode.propertyIds == '2') {
          _list.add(mode);
        }
      });
    } else if (conditions == '小额快贷') {
      _homeScreem.forEach((mode) {
        if (mode.propertyIds == '3') {
          _list.add(mode);
        }
      });
    } else if (conditions == '大额低息') {
      _homeScreem.forEach((mode) {
        if (mode.propertyIds == '4') {
          _list.add(mode);
        }
      });
    } else {
      _list = _homeScreem;
    }
    _homeScreemup = _list;
    setState(() {});
  }

  _upDadaDate(String conditions) {
    List<HomeScreem> _list = new List<HomeScreem>();
    if (conditions == '不限期限') {
      _list = _homeScreem;
    } else if (conditions == '1-3个月') {
      _homeScreem.forEach((mode) {
        if (mode.deadline == '1-3') {
          _list.add(mode);
        }
      });
    } else if (conditions == '3-6个月') {
      _homeScreem.forEach((mode) {
        if (mode.deadline == '3-6') {
          _list.add(mode);
        }
      });
    } else if (conditions == '6-12个月') {
      _homeScreem.forEach((mode) {
        if (mode.deadline == '6-12') {
          _list.add(mode);
        }
      });
    } else if (conditions == '1年以上') {
      _homeScreem.forEach((mode) {
        if (mode.deadline == '1年以上') {
          _list.add(mode);
        }
      });
    } else {
      _list = _homeScreem;
    }
    _homeScreemup = _list;
    setState(() {});
  }

  _upDadaMoney(String conditions) {
    List<HomeScreem> _list = new List<HomeScreem>();
    if (conditions == '不限金额') {
      _list = _homeScreem;
    } else if (conditions == '0-5000') {
      _homeScreem.forEach((mode) {
        if (int.parse(mode.limit) < 5001) {
          _list.add(mode);
        }
      });
    } else if (conditions == '5000-10000') {
      _homeScreem.forEach((mode) {
        if (int.parse(mode.limit) < 10001 && int.parse(mode.limit) > 5000) {
          _list.add(mode);
        }
      });
    } else if (conditions == '10000-20000') {
      _homeScreem.forEach((mode) {
        if (int.parse(mode.limit) < 20001 && int.parse(mode.limit) > 10000) {
          _list.add(mode);
        }
      });
    } else if (conditions == '20000以上') {
      _homeScreem.forEach((mode) {
        if (int.parse(mode.limit) > 20000) {
          _list.add(mode);
        }
      });
    } else {
      _list = _homeScreem;
    }
    _homeScreemup = _list;
    setState(() {});
  }

  _items(String type) {
    if (type == 'money') {
      List<Widget> items = [];
      _screenCashAmount.forEach((mode) {
        items.add(_itemMoney(mode));
      });
      setState(() {});
      return items;
    }
    if (type == 'date') {
      List<Widget> items = [];
      _screenDeadLine.forEach((mode) {
        items.add(_itemDate(mode));
      });
      setState(() {});

      return items;
    }
    if (type == 'sort') {
      List<Widget> items = [];
      _screenCompositeRank.forEach((mode) {
        items.add(_itemSort(mode));
      });
      setState(() {});

      return items;
    }
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
          '贷款分类',
          style: TextStyle(color: ColorUtils.appMain2TextColor, fontSize: 18),
        ),
        Expanded(
          child: Container(),
          flex: 1,
        ),
      ],
    );
  }

  Widget _screenType() {
    return Container(
      height: 48,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _upBool('money');
            },
            child: Row(
              children: <Widget>[
                Text(
                  _moneyText,
                  style: TextStyle(
                      color: ColorUtils.appMain2TextColor, fontSize: 15),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4),
                ),
                Icon(
                  _money ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: ColorUtils.appMain2TextColor,
                  size: 20,
                )
              ],
            ),
          ),
          Expanded(child: Container(), flex: 1),
          GestureDetector(
            onTap: () {
              _upBool('date');
            },
            child: Row(
              children: <Widget>[
                Text(
                  _dateText,
                  style: TextStyle(
                      color: ColorUtils.appMain2TextColor, fontSize: 15),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4),
                ),
                Icon(
                  _date ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: ColorUtils.appMain2TextColor,
                  size: 20,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(),
            flex: 1,
          ),
          GestureDetector(
            onTap: () {
              _upBool('sort');
            },
            child: Row(
              children: <Widget>[
                Text(
                  _sortText,
                  style: TextStyle(
                      color: ColorUtils.appMain2TextColor, fontSize: 15),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4),
                ),
                Icon(
                  _sort ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: ColorUtils.appMain2TextColor,
                  size: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _upBool(String type) {
    if (type == 'money') {
      _date = false;
      _sort = false;
      if (_money == true) {
      } else {
        _money = true;
      }
      _isShowItem = true;
      _string = 'money';
    }
    if (type == 'date') {
      _money = false;
      _sort = false;
      if (_date == true) {
      } else {
        _date = true;
      }
      _isShowItem = true;
      _string = 'date';
    }
    if (type == 'sort') {
      _money = false;
      _date = false;

      if (_sort == true) {
      } else {
        _sort = true;
      }
      _isShowItem = true;
      _string = 'sort';
    }
    setState(() {});
  }
}
