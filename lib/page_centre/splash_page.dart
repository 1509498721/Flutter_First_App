import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/model/versionup_model.dart';
import 'package:the_fish_fly/text_centre/set_text_init.dart';
import 'package:the_fish_fly/utils/dio_utils.dart';
import 'package:the_fish_fly/utils/get_phone_message.dart';
import 'dart:async';

import 'package:the_fish_fly/utils/shared_preferences_utils.dart';
import 'package:the_fish_fly/widget/tab_navigator.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer _timerPeriodic;
  int count = 1;

  @override
  void initState() {
    super.initState();
//    _version();
    Sp.userMessageInput();
    _timerPeriodic = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (count == 0) {
        _timerPeriodic.cancel();
        _goLogin();
        return;
      }
      count--;
      setState(() {
        count;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //设置状态栏高度
   PhoneMessage.statusBarHeight = MediaQuery.of(context).padding.top;
//    PhoneMessage.statusBarHeight =0;
//    _initAppData();
    return Image.asset('images/loading_app.png',fit: BoxFit.fill,);
  }

  void _goLogin() {
    Navigator.pop(context);
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => TabNavigator()),
    );
  }
}

void _version() async{

  try {
    Map<String, dynamic> resJson;
    final res = await HttpUtil.getInstance().post(CommonCode.POST_VERSION_SELECTDETAIL, data: {"appId": 1});

    if (res is String) {
      resJson = json.decode(res);
    } else if (res is Map<String, dynamic>) {
      resJson = res;
    } else {
      throw DioError(message: '数据解析错误');
    }
    var modelData = VersionModel.fromJson(resJson);
  } catch (e) {
    print("-----" + e.toString());
  }

}

void _initAppData() {
  //设置语言
  SetTextInit.setTextInit();
  SetTextInit.updateLanguage("ch");
}
