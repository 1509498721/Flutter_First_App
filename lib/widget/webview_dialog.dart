import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(right: 36, left: 36),
        child: Container(
          color: ColorUtils.appWhiteColor,
          height: 230,
          width: double.infinity,
          child: Scrollbar(child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  '关注微信服务号',
                  style: TextStyle(
                    color: ColorUtils.appMain2TextColor,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),

              Expanded(
                child: Container(),
                flex: 1,
              ),
              Padding(
                  padding: EdgeInsets.only( right: 24, left: 24),
                  child: Text(
                    '关注【鱼儿飞】服务号获得最新贷款信息 和放款攻略，随时随地一键申请。请在微 信搜索框粘贴搜索【鱼儿飞搜索】服务号 点击关注即可。',
                    style: TextStyle(
                        color: ColorUtils.appMain2TextColor,
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        decoration: TextDecoration.none),
                  )),
              Expanded(
                child: Container(),
                flex: 1,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, right: 24, left: 24),
                child: Row(
                  children: <Widget>[
                    Container(height: 30,child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: ColorUtils.appWeiXinColor,
                      child: Text(
                        "我在想想",
                        style: TextStyle(
                            color: ColorUtils.appWhiteColor, fontSize: 13),
                      ),
                    ),),
                    Expanded(
                      child: Container(),
                      flex: 1,
                    ),
                    Container(height: 30, child:FlatButton(
                      onPressed: () async {
                        ClipboardData data = new ClipboardData(text:"鱼儿飞搜索");
                        Clipboard.setData(data);
                        if (await canLaunch ("weixin://")){
                          launch("weixin://");
                        }else{
                          Toast.show("您未安装微信", context);
                        }
                        Navigator.pop(context);
                      },
                      color: ColorUtils.appWeiXinColor,
                      child: Text(
                        "去关注",
                        style: TextStyle(
                            color: ColorUtils.appWhiteColor, fontSize: 13),
                      ),
                    ) ,),
                  ],
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
