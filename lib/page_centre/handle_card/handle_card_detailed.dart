import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/model/bank_detailed.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/utils/dio_utils.dart';
import 'package:the_fish_fly/utils/get_phone_message.dart';

import 'handle_card_detailed_list.dart';

class BankCardDetailed extends StatefulWidget {
  final int bankId;
  final String bankName;
  final String bankImage;
  final String bankHint;
  final String bankSpeed;
  final double bankLines;
  final String bankThrough;

  const BankCardDetailed(
      {Key key,
      this.bankId,
      this.bankName,
      this.bankImage,
      this.bankHint,
      this.bankSpeed,
      this.bankLines,
      this.bankThrough})
      : super(key: key);

  @override
  _BankCardDetailedState createState() => new _BankCardDetailedState();
}

class _BankCardDetailedState extends State<BankCardDetailed> {
  //刷新总样式
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  BankDetailedModel _bankDetailedModel;
  List<BankDetailedRows> _bankDetailedList;

  _initDetailed() async {
    try {
      Map<String, dynamic> resJson;
      final res = await HttpUtil.getInstance().post(
          CommonCode.POST_GETADVERTISINGCARD,
          data: {"bankId": widget.bankId});
      if (res is String) {
        resJson = json.decode(res);
      } else if (res is Map<String, dynamic>) {
        resJson = res;
      } else {
        throw DioError(message: '数据解析错误');
      }
      var modelData = BankDetailedModel.fromJson(resJson);

      if (modelData.code == "1") {
        _bankDetailedModel = modelData;
        _bankDetailedList = modelData.data.rows;
        setState(() {});
      } else {}
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    _initDetailed();
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
              ),
            ),
            _appBar(),
            Padding(
              padding: EdgeInsets.only(right: 16, left: 16),
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(right: 4, left: 4, top: 5),
                      height: 124,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                                color: ColorUtils.gradientEnd13Color,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 2.0,
                                spreadRadius: 1.0)
                          ]),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: ColorUtils.appWhiteColor,
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 22,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: <Widget>[
                                  Image.network(
                                    widget.bankImage,
                                    width: 36,
                                    height: 36,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.bankName,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                ColorUtils.appMain2TextColor),
                                      ),
                                      Text(
                                        widget.bankHint,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                ColorUtils.bankCardMainColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '批卡速度',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: ColorUtils
                                            .appTopAdvertisingTextColor),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    widget.bankSpeed+'天',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: ColorUtils
                                            .appMain2TextColor),
                                  ),

                                  Expanded(
                                    child: Container(),
                                    flex: 1,
                                  ),
                                  Text(
                                    '平均额度',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: ColorUtils
                                            .appTopAdvertisingTextColor),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    widget.bankLines.toString(),
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: ColorUtils
                                            .appMain2TextColor),
                                  ),

                                  Expanded(
                                    child: Container(),
                                    flex: 1,
                                  ),
                                  Text(
                                    '通过率',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: ColorUtils
                                            .appTopAdvertisingTextColor),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    widget.bankThrough,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: ColorUtils
                                            .appMain2TextColor),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: DetailedListNav(_bankDetailedList),
                  )
                ],
              ),
            )
          ],
        ),
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
          '卡中心',
          style: TextStyle(color: ColorUtils.appMain2TextColor, fontSize: 18),
        ),
        Expanded(
          child: Container(),
          flex: 1,
        ),
        Container(padding: EdgeInsets.all(20), child: Container()),
      ],
    );
  }
}
