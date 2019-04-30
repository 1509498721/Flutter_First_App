import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/common/common_ui.dart';
import 'package:the_fish_fly/model/login_model.dart';
import 'package:the_fish_fly/model/ssm_model.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/utils/dio_utils.dart';
import 'package:the_fish_fly/utils/get_phone_message.dart';
import 'package:the_fish_fly/utils/shared_preferences_utils.dart';
import 'package:the_fish_fly/widget/tab_navigator.dart';
import 'package:toast/toast.dart';

///可用时使用的字体样式。
final TextStyle _availableStyle = TextStyle(
  fontSize: 12,
  color: ColorUtils.appLoginTextColor,
);

/// 不可用时使用的样式。
final TextStyle _unavailableStyle = TextStyle(
  fontSize: 12,
  color: ColorUtils.appLoginTextColor,
);

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// 倒计时的秒数，默认60秒。
  int countdown = 60;

  /// 倒计时的计时器。
  Timer _timer;

  bool available = true;

  /// 当前倒计时的秒数。
  int _seconds;

  /// 当前的字体样式。
  TextStyle inkWellStyle = _availableStyle;

  /// 当前的文本。
  String _verifyStr = '获取验证码';

  /// 启动倒计时的计时器。
  void _startTimer() {
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = countdown;
        inkWellStyle = _availableStyle;
        setState(() {});
        return;
      }
      _seconds--;
      _verifyStr = '已发送$_seconds' + 's';
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = '重新发送';
      }
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
  }

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //验证码的控制器
  TextEditingController codeController = TextEditingController();

  GlobalKey<EasyRefreshState> _LoginKey =
  new GlobalKey<EasyRefreshState>();
  @override
  void initState() {
    super.initState();
    _seconds = countdown;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: EasyRefresh(
          key: _LoginKey,
      child: Stack(
        children: <Widget>[
          Container(
            height: 280,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              ColorUtils.gradientStartColor,
              ColorUtils.gradientEndColor
            ], begin: FractionalOffset(1, 0), end: FractionalOffset(0, 1))),
          ),
          Container(
              padding: EdgeInsets.only(top: 32),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: PhoneMessage.statusBarHeight),
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(30),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: ColorUtils.appLoginTextColor,
                            size: 18,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Text(
                        '手机验证码登陆',
                        style: TextStyle(
                            fontSize: 24, color: ColorUtils.appWhiteColor),
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Container(
                        padding: EdgeInsets.all(30),
                        child: Container()
                      ),
                    ],
                  ),

                  Padding(
                      padding: EdgeInsets.only(top: 40,right: 26, left: 26),
                      child: CommonUi.orangeContainer(
                        child: Padding(
                          padding: EdgeInsets.only(right: 24, left: 24),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 16),
                              ),
                              TextField(
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: '请输入手机号',
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                        color:
                                            ColorUtils.appHomePagingTextColor)),
                                autofocus: false,
                              ),
                              Container(
                                color: ColorUtils.appLoginSegmentationColor,
                                height: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 32),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                        controller: codeController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            labelText: '验证码',
                                            border: InputBorder.none,
                                            labelStyle: TextStyle(
                                                color: ColorUtils
                                                    .appHomePagingTextColor)),
                                        obscureText: false),
                                  ),
                                  Expanded(
                                    child: Container(),
                                    flex: 1,
                                  ),
                                  Container(
                                    child: available
                                        ? InkWell(
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              color:
                                                  ColorUtils.appLoginBacColor,
                                              child: Text(
                                                '  $_verifyStr  ',
                                                style: inkWellStyle,
                                              ),
                                            ),
                                            onTap: (_seconds == countdown)
                                                ? () {
                                                    if (phoneController
                                                        .text.isEmpty) {
                                                      Toast.show(
                                                          '手机号码不能为空', context);
                                                      return;
                                                    } else {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                              FocusNode());
                                                      _sendSSM(
                                                          phoneController.text);
                                                    }
                                                  }
                                                : null,
                                          )
                                        : InkWell(
                                            child: Text(
                                              '获取验证码',
                                              style: _unavailableStyle,
                                            ),
                                          ),
                                  )
                                ],
                              ),
                              Container(
                                color: ColorUtils.appLoginSegmentationColor,
                                height: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 56),
                              )
                            ],
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(right: 26,left: 26,),
                    child: Column(children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            height: 16,
                            color: ColorUtils.appLoginTextColor,
                          ),
                          Center(
                            child: Padding(
                                padding: EdgeInsets.only(
                                  right: 28,
                                  left: 28,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    _loginInfo(
                                        phoneController.text, codeController.text);
                                  },
                                  child: Container(
                                    color: ColorUtils.appLoginBacColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(left: 8),
                                            child: Text(
                                              '立即登录',
                                              style: TextStyle(
                                                  color:
                                                  ColorUtils.appLoginTextColor,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(),
                                            flex: 1,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: ColorUtils.appLoginTextColor,
                                              size: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                              flex: 1,
                            ),
                            Text(
                              '登陆即代表您同意',
                              style: TextStyle(
                                  color: ColorUtils.appHomePagingTextColor,
                                  fontSize: 12),
                            ),
                            Text(
                              '《鱼儿飞用户注册协议》',
                              style: TextStyle(
                                  color: ColorUtils.appLoginBacColor, fontSize: 12),
                            ),
                            Expanded(
                              child: Container(),
                              flex: 1,
                            ),
                          ],
                        ),
                      )
                    ],),
                  ),

                ],
              ))
        ],
      ),
    ));
  }

  _sendSSM(String userPhone) async {
    try {
      Map<String, dynamic> resJson;
      final res = await HttpUtil.getInstance()
          .post(CommonCode.POST_GET_PHONE_SMS, data: {"Phone": userPhone});
      if (res is String) {
        resJson = json.decode(res);
      } else if (res is Map<String, dynamic>) {
        resJson = res;
      } else {
        throw DioError(message: '数据解析错误');
      }
      var modelData = SSMModel.fromJson(resJson);
      if (modelData.code == "9527") {
        Toast.show('当日获取短信次数已达上线', context);
      }
      if (modelData.code == "200") {
        _startTimer();
        setState(() {
          inkWellStyle = _unavailableStyle;
          _verifyStr = '已发送$_seconds' + 's';
        });
        Toast.show('发送成功', context);
      } else {
        Toast.show(modelData.msg, context);
      }
    } catch (e) {
      print("-----" + e.toString());
    }
  }

  _loginInfo(String userPhone, String userSsmCode) async {
    if (userPhone.isEmpty) {
      Toast.show('手机号码为空', context);
      return;
    }
    if (userSsmCode.isEmpty) {
      Toast.show('验证码为空', context);
      return;
    }

    try {
      Map<String, dynamic> resJson;
      final res = await HttpUtil.getInstance().post(CommonCode.POST_ADMIN_LOGIN,
          data: {"Phone": userPhone, "PhoneCode": userSsmCode});
      if (res is String) {
        resJson = json.decode(res);
      } else if (res is Map<String, dynamic>) {
        resJson = res;
      } else {
        throw DioError(message: '数据解析错误');
      }
      var modelData = LoginModel.fromJson(resJson);

      if (modelData.code == "200") {
        print(modelData.items[0].id.toString() + modelData.items[0].frendSource);
        Sp.setLoginMessage(modelData);
        Sp.userMessageInput();
        Navigator.pop(context);
        Navigator.push(context, new MaterialPageRoute(builder: (context) => TabNavigator()),
        );
      } else {
        Toast.show(modelData.msg, context);
      }
    } catch (e) {
      print("-----" + e.toString());
      Navigator.pop(context);
    }
  }
}
