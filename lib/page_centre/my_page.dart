import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/page_centre/login_page.dart';
import 'package:the_fish_fly/page_centre/my_nav/weixing_dialog.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/utils/get_phone_message.dart';
import 'package:the_fish_fly/utils/shared_preferences_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String _myToken = null;
  String _myName = null;
  String _myHead = null;

  //是否显示商务合作QQ
  var _isShowBusiness = false;

  //刷新总样式
  GlobalKey<EasyRefreshState> _myFragment = new GlobalKey<EasyRefreshState>();

  @override
  void initState() {
    super.initState();
    _myToken = _myName = CommonCode.My_TOKENTInfo;
    print(_myToken);
    _myName = CommonCode.USER_PHONEInfo;
  }

  Future<void> _pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtils.appBac,
        body: Padding(
            padding: EdgeInsets.only(
                top: PhoneMessage.statusBarHeight, right: 20, left: 20),
            child: EasyRefresh(
              key: _myFragment,
              child: Padding(
                padding: EdgeInsets.only(top: 48),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _myToken == null ?  _jumpLogin() :_jumpMyAdmin();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorUtils.appMainFragmentBacColor,
                            borderRadius: BorderRadius.circular(4)),
                        height: 140,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(right: 24, left: 24),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  _myToken == null
                                      ? 'images/user_img_no.png'
                                      : 'images/user_img_no_new.png',
                                  height: 60,
                                  width: 60,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 12),
                                  child: Text(
                                    _myToken == null
                                        ? '去登录'
                                        : _myName.substring(0, 8),
                                    style: TextStyle(
                                        color: ColorUtils.appWhiteColor,
                                        fontSize: 24),
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                  flex: 1,
                                ),
                                Image.asset('images/me_jump_user_new.png')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                            color: ColorUtils.appTabNavigator,
                            borderRadius: BorderRadius.circular(4)),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'images/im_paging_rig.png',
                              width: 4,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Image.asset('images/mine_message_new.png'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                '我的消息',
                                style: TextStyle(
                                    color: ColorUtils.appWhiteColor,
                                    fontSize: 14),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                              flex: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Image.asset('images/item_right_new.png'),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog<Null>(
                            context: context, //BuildContext对象
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return WeiXinDialog();
                            });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              color: ColorUtils.appTabNavigator,
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'images/im_paging_rig.png',
                                width: 4,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child:
                                    Image.asset('images/mine_weixin_new.png'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  '微信服务号',
                                  style: TextStyle(
                                      color: ColorUtils.appWhiteColor,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                                flex: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Image.asset('images/item_right_new.png'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorUtils.appTabNavigator,
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                var url;
                                if (Platform.isAndroid) {
                                  url =
                                      'mqqwpa://im/chat?chat_type=wpa&uin=122883152';
                                } else {
                                  url =
                                      'mqq://im/chat?chat_type=wpa&uin=122883152&version=1&src_type=web';
                                } // 确认一下url是否可启动
                                if (await canLaunch(url)) {
                                  launch(url); // 启动QQ
                                } else {
                                  Toast.show("您未安装QQ", context);
                                  // 自己封装的一个 Toast
                                }
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: ColorUtils.appTabNavigator,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Image.asset(
                                          'images/mine_server_new.png'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Text(
                                        '在线客服',
                                        style: TextStyle(
                                            color: ColorUtils.appWhiteColor,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                      flex: 1,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 16),
                                      child: Image.asset(
                                          'images/item_right_new.png'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: ColorUtils.appHomePagingGangColor,
                              height: 1,
                            ),
                            Container(
                              height: 48,
                              decoration: BoxDecoration(
                                  color: ColorUtils.appTabNavigator,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Image.asset(
                                        'images/mine_credit_new.png'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Text(
                                      '征信查询',
                                      style: TextStyle(
                                          color: ColorUtils.appWhiteColor,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                    flex: 1,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: Image.asset(
                                        'images/item_right_new.png'),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              color: ColorUtils.appHomePagingGangColor,
                              height: 1,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_isShowBusiness) {
                                  setState(() {
                                    _isShowBusiness = false;
                                    print(_isShowBusiness);
                                  });
                                } else {
                                  setState(() {
                                    _isShowBusiness = true;
                                    print(_isShowBusiness);
                                  });
                                }
                              },
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    color: ColorUtils.appTabNavigator,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Image.asset(
                                          'images/mine_cooperation_new.png'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Text(
                                        '商务合作',
                                        style: TextStyle(
                                            color: ColorUtils.appWhiteColor,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                      flex: 1,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 16),
                                      child: _isShowBusiness
                                          ? Image.asset('images/item_bom.png')
                                          : Image.asset(
                                              'images/item_right_new.png'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Offstage(
                              offstage: _isShowBusiness ? false : true, //这里控制
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    color: ColorUtils.appHomePagingGangColor,
                                    height: 1,
                                  ),
                                  Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                        color: ColorUtils.appTabNavigator,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(),
                                          flex: 1,
                                        ),
                                        Text(
                                          '商务QQ：2597103601',
                                          style: TextStyle(
                                              color: ColorUtils
                                                  .appHomeAdvertisingColor,
                                              fontSize: 12),
                                        ),
                                        Expanded(
                                          child: Container(),
                                          flex: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: _myToken == null ? true : false, //这里控制
                      child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: GestureDetector(
                          onTap: () async {
                            Sp.clearLoginMessage();
                            setState(() {
                              _myToken=null;
                              _myName=null;
                            });
//                             _pop();
                          },
                          child: Container(
                            height: 48,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                'images/mine_server_but_new.png',
                              ),
                            )),
                            child: Center(
                                child: Text(
                              '退出账户',
                              style: TextStyle(color: ColorUtils.appWhiteColor),
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  _jumpMyAdmin() {}

  _jumpLogin() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
