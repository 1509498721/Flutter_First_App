import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/model/bank_advertising.dart';
import 'package:the_fish_fly/model/bank_hot.dart';
import 'package:the_fish_fly/model/bank_main_show.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/utils/dio_utils.dart';
import 'package:the_fish_fly/utils/get_phone_message.dart';
import 'package:the_fish_fly/widget/material_header.dart';

import 'handle_card/handle_card_advertising.dart';
import 'handle_card/handle_card_hot.dart';
import 'handle_card/handle_card_main_list.dart';
import 'handle_card/handle_card_queries.dart';

class HandleCardPage extends StatefulWidget {
  @override
  _HandleCardState createState() => _HandleCardState();
}

class _HandleCardState extends State<HandleCardPage>
    with AutomaticKeepAliveClientMixin<HandleCardPage> {
  //刷新总样式
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  //刷新头
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();

  List<BankAdvertisingData> _bankAdvertisingList;
  List<BankHotData> _bankHotList;
  List<BankMainShowData> _mainShowDataList;

  _initBankAdvertising() async {
    try {
      Map<String, dynamic> resJson;
      final res =
          await HttpUtil.getInstance().post(CommonCode.POST_GET_ADVERTISING);
      if (res is String) {
        resJson = json.decode(res);
      } else if (res is Map<String, dynamic>) {
        resJson = res;
      } else {
        throw DioError(message: '数据解析错误');
      }
      var modelData = BankAdvertisingModel.fromJson(resJson);

      if (modelData.code == "1") {
        _bankAdvertisingList = modelData.data;
        setState(() {});
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  _initBankHot() async {
    try {
      Map<String, dynamic> resJson;
      final res =
          await HttpUtil.getInstance().post(CommonCode.POST_BANKCLASSIFY);
      if (res is String) {
        resJson = json.decode(res);
      } else if (res is Map<String, dynamic>) {
        resJson = res;
      } else {
        throw DioError(message: '数据解析错误');
      }
      var modelData = BankHotModel.fromJson(resJson);

      if (modelData.code == "1") {
        _bankHotList = modelData.data;
        setState(() {});
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  _initBankList() async {
    try {
      Map<String, dynamic> resJson;
      final res = await HttpUtil.getInstance().post(CommonCode.POST_BANKLIST);
      if (res is String) {
        resJson = json.decode(res);
      } else if (res is Map<String, dynamic>) {
        resJson = res;
      } else {
        throw DioError(message: '数据解析错误');
      }
      var modelData = BankMainShow.fromJson(resJson);
      if (modelData.code == "1") {
        _mainShowDataList = modelData.data.rows;
        setState(() {});
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _initBankAdvertising();
    _initBankHot();
    _initBankList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtils.appWhiteColor,
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(top: PhoneMessage.statusBarHeight),
            child: EasyRefresh(
                key: _easyRefreshKey,
                child: Column(
                  children: <Widget>[
                    _appBar(),
                    Padding(
                      padding: EdgeInsets.only(right: 15, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '精选推荐',
                            style: TextStyle(fontSize: 16),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                          BankAdvertisingNav(_bankAdvertisingList),
                          Text(
                            '热门银行',
                            style: TextStyle(fontSize: 16),
                          ),
                          BankHotNav(_bankHotList),
                          Text(
                            '热门推荐',
                            style: TextStyle(fontSize: 16),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 32),
                          ),
                          BankListNav(_mainShowDataList)
                        ],
                      ),
                    ),
                  ],
                ),
                //视图刷新
                onRefresh: () async {
                  await new Future.delayed(const Duration(seconds: 1), () {
                    setState(() {});
                  });
                },
                //自定义刷新头部
                refreshHeader: MaterialHeader(
                  key: _headerKey,
                )),
          ),
        ));
  }

  Widget _appBar() {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
        ),
        Expanded(
          child: Container(),
          flex: 1,
        ),
        Text(
          '信用卡超市',
          style: TextStyle(fontSize: 18),
        ),
        Expanded(
          child: Container(),
          flex: 1,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => BankCardQueries(_bankHotList)));
          },
          child: Container(
            color: ColorUtils.appWhiteColor,
            padding: EdgeInsets.all(20),
            child: Image.asset(
              'images/handle_card_2x.png',
              width: 18,
              height: 15,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
