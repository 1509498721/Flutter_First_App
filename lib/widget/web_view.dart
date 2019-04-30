import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebView extends StatefulWidget {
  String url;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView({
    this.url,
    this.title,
    this.hideAppBar = false,
    this.backForbid = false,
  }) {
//    if (url != null && url.contains('ctrip.com')) {
//      //fix 携程H5 http://无法打开问题
//      url = url.replaceAll("http://", 'https://');
//    }
  }

  @override
  _WebViewState createState() => _WebViewState();
}

// 获取安装地址
Future<String> get _apkLocalPath async {
  final directory = await getExternalStorageDirectory();
  return directory.path;
}

// 下载
Future<void> executeDownload(String url) async {
  final path = await _apkLocalPath;
  //下载
  final taskId = await FlutterDownloader.enqueue(
      url: url + '/' + url.substring(url.length - 8, url.length),
      savedDir: path,
      showNotification: true,
      openFileFromNotification: true);
  FlutterDownloader.registerCallback((id, status, progress) {
    // 当下载完成时，调用安装
    if (taskId == id && status == DownloadTaskStatus.complete) {
      _installApk(url);
    }
  });
}

// 安装
Future<Null> _installApk(String url) async {
  // XXXXX为项目名
  const platform = const MethodChannel("鱼儿飞");
  try {
    final path = await _apkLocalPath;
    // 调用app地址
    await platform.invokeMethod('install', {
      'path': path + '/' + url.substring(url.length - 8, url.length),
    });
  } on PlatformException catch (_) {}
}

class _WebViewState extends State<WebView> {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;
  int isf = 0;
  String urls = "";
  bool _isShow = false;

  @override
  void initState() {
    super.initState();
    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {
      print(url);
      urls = url;
//      if (exiting) {
//      } else {
//        if (Platform.isAndroid) {
//          if (isf == 3) {
//            // launch(url);
//            exiting = true;
//          } else {
//            isf++;
//          }
//        } else {
//          if (isf == 4) {
//            // launch(url);
//            Toast.show('点击浏览器跳转', context);
//            exiting = true;
//          } else {
//            isf++;
//          }
//        }
// }
      if (url.substring(url.length - 5, url.length) != '.html') {
        print("不不跳转三方连接");
      } else {
        launch(urls);
//        Toast.show('请使用右上方浏览器按钮打开进行下载', context);
//        print("跳转三方连接");

      }
    });
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if (_isToMain(state.url) && !exiting) {
            if (widget.backForbid) {
              webviewReference.launch(widget.url);
            } else {
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
    _onHttpError =
        webviewReference.onHttpError.listen((WebViewHttpError error) {});
  }

  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {
    _onStateChanged.cancel();
    _onUrlChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(ColorUtils.appWhiteColor),
          Expanded(
              child: WebviewScaffold(
            userAgent: 'null',
            //防止携程H5页面重定向到打开携程APP ctrip://wireless/xxx的网址
            url: widget.url,
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            withJavascript: true,
            initialChild: Container(
              color: ColorUtils.appWhiteColor,
              child: Center(
                child: Text(
                  '加载中...',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }

  _appBar(Color backgroundColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 48,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 26,
                ),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
            Center(
              child: Text(
                widget.title ?? '',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Expanded(
              child: Container(),
              flex: 1,
            ),
            GestureDetector(
              onTap: () {
                launch(urls);
              },
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Center(
                  child: Image.asset(
                    'images/liulanqi.png',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
