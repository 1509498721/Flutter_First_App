import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_fish_fly/page_centre/fish_home_page.dart';
import 'package:the_fish_fly/page_centre/my_page.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  final _defaultColor = ColorUtils.appMain2TextColor;
  final _activeColor = ColorUtils.appMainTextColor;

  final double _defaultSize = 14;
  final double _activeSize = 14;
  int _currentIndex = 0;
  Future<void> _pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: (){
        _pop();
        return Future.value(false);
      },
      child:  Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: <Widget>[FishHomePage(), MyPage()],
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              _controller.jumpToPage(index);
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorUtils.appTabNavigator,
            items: [
              BottomNavigationBarItem(
                  icon: new Container(),
                  activeIcon: new Container(),
                  title: Padding(padding: EdgeInsets.only(top: 8),child: Column(
                    children: <Widget>[
                      Text("首页",
                          style: TextStyle(
                              height: 0,
                              color: _currentIndex != 0
                                  ? _defaultColor
                                  : _activeColor,
                              fontSize: _currentIndex != 0
                                  ? _defaultSize
                                  : _activeSize)),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Offstage(
                          offstage: _currentIndex != 0 ? true : false, //这里控制
                          child: Container(
                            width: 30,
                            color: ColorUtils.appMainTextColor,
                            height: 3,
                          ),
                        ),
                      ),
                    ],
                  ),)),
              BottomNavigationBarItem(
                  icon: new Container(),
                  activeIcon: new Container(),
                  title: Padding(padding: EdgeInsets.only(top: 8),child: Column(
                    children: <Widget>[
                      Text("我的",
                          style: TextStyle(
                              height: 0,
                              color: _currentIndex != 1
                                  ? _defaultColor
                                  : _activeColor,
                              fontSize: _currentIndex != 1
                                  ? _defaultSize
                                  : _activeSize)),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Offstage(
                          offstage: _currentIndex != 1 ? true : false, //这里控制
                          child: Container(
                            width: 30,
                            color: ColorUtils.appMainTextColor,
                            height: 3,
                          ),
                        ),
                      ),
                    ],
                  ),))
            ]),
      ),
    );
  }
}
