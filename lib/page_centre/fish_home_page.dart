import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/model/advertising_model.dart';
import 'package:the_fish_fly/model/classification_model.dart';
import 'package:the_fish_fly/model/home_screen_model.dart';
import 'package:the_fish_fly/model/paging_model.dart';
import 'package:the_fish_fly/model/screen_model.dart';
import 'package:the_fish_fly/model/versionup_model.dart';
import 'package:the_fish_fly/page_centre/home_nav/advertising_nav.dart';

import 'package:the_fish_fly/page_centre/home_nav/local_nav.dart';
import 'package:the_fish_fly/page_centre/home_nav/paging_nav.dart';
import 'package:the_fish_fly/page_centre/home_nav/screen/screen_more_nav.dart';
import 'package:the_fish_fly/page_centre/home_nav/search_nav_info.dart';
import 'package:the_fish_fly/page_centre/home_nav/version_dialog_1.dart';
import 'package:the_fish_fly/page_centre/home_nav/version_dialog_2.dart';
import 'package:the_fish_fly/utils/color_utils.dart';
import 'package:the_fish_fly/utils/dio_utils.dart';
import 'package:the_fish_fly/utils/get_phone_message.dart';
import 'package:the_fish_fly/widget/loading_container.dart';
import 'package:the_fish_fly/widget/material_header.dart';
class FishHomePage extends StatefulWidget {
  @override
  _FishHomePageState createState() => _FishHomePageState();
}

class _FishHomePageState extends State<FishHomePage>
    with AutomaticKeepAliveClientMixin<FishHomePage> {
  bool _isShowSearch = false;

  //首页顶部按钮
  List<ClassificationPropertyModel> localNavList;

  //首页广告
  List<AdvertisingGoodsModel> advertisingNavList=new  List<AdvertisingGoodsModel>();
  //首页分页数据
  List<PagingRowModel> pagingRowList;

  //搜索数据
  List<PagingRowModel> searchRowList;

  //刷新总样式
  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();

  int num = 0;

  //加载
  var _loading = false;

  //刷新头
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();

  void _initTopFourBut() async {
    try {
      final res =
          await HttpUtil.getInstance().get(CommonCode.GET_INDEX_TOP_ITEM);
      var modelData = ClassificationModel.fromJson(res);
      if(localNavList==modelData.property) return;
      localNavList = modelData.property;
    } catch (e) {
      print("-----四个按钮" + e.toString());
    }
  }

  void _initMainAdvertising() async {
    try {
      final res = await HttpUtil.getInstance().get(CommonCode.GET_INDEX_PRODUCT);
      var modelData = AdvertisingModel.fromJson(res);
      if(advertisingNavList==modelData.goods){
        return;
      }else{
        advertisingNavList = modelData.goods;
      }
    } catch (e) {
      print("-----广告" + e.toString());
    }
  }

  void _initMainPaging() async {
    try {
      final res =
          await HttpUtil.getInstance().get(CommonCode.GET_PAGE_GOODS_LIST);
      var modelData = PagingModel.fromJson(res);
      if(pagingRowList==modelData.rows) return;
      pagingRowList = modelData.rows;

      _loading = false;
    } catch (e) {
      print("-----分页" + e.toString());
      _loading = false;
    } finally {

    }
  }

  _initScreen() async {
    try {
      final res =
          await HttpUtil.getInstance().get(CommonCode.GET_APP_TYPE_LIST);
      var modelData = ScreenModel.fromJson(res);
      if(CommonCode.screenModel == modelData) return;

      CommonCode.screenModel = modelData;

    } catch (e) {
      print("-----筛选" + e.toString());
    }
  }

  _initScreenDada() async {
    try {
      Map<String, dynamic> resJson;
      final res =
          await HttpUtil.getInstance().post(CommonCode.POST_GET_GOOD_LIST);
      if (res is String) {
        resJson = json.decode(res);
      } else if (res is Map<String, dynamic>) {
        resJson = res;
      } else {
        throw DioError(message: '数据解析错误');
      }
      var modelData = HomeScreenModel.fromJson(resJson);
      if(CommonCode.homeScreem ==  modelData.items) return;
      CommonCode.homeScreem = modelData.items;
      setState(() {});
    } catch (e) {
    }
  }

  void _version() async {
    if(CommonCode.isFirst==false){
      return;
    }
    try {
      int id;
      if(Platform.isAndroid){
        id=1;
      }else{
        id=2;
      }
      CommonCode.isFirst=false;

      Map<String, dynamic> resJson;
      final res = await HttpUtil.getInstance()
          .post(CommonCode.POST_VERSION_SELECTDETAIL, data: {"appId": id});
      if (res is String) {
        resJson = json.decode(res);
      } else if (res is Map<String, dynamic>) {
        resJson = res;
      } else {
        throw DioError(message:'数据解析错误');
      }
      var modelData = VersionModel.fromJson(resJson);
      if (CommonCode.VERSIONS_CODE != modelData.items[0].versionId) {
        if (modelData.items[0].type == 2) {
          showDialog<Null>(
              context: context, //BuildContext对象
              barrierDismissible: false,
              builder: (BuildContext context) {
                return VersionDialog2();
              });
          _pop();
        } else {
          showDialog<Null>(
              context: context, //BuildContext对象
              barrierDismissible: false,
              builder: (BuildContext context) {
                return VersionDialog1();
              });
        }
      }
    } catch (e) {
      print("-----" + e.toString());
    }
  }

  Future<void> _pop() async {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  void initState() {
    super.initState();
    _version();
    //头部的四个按钮
    _initTopFourBut();
    //首页广告位
    _initMainAdvertising();
    //分页数据
    _initMainPaging();
    //筛选itme
    _initScreen();
    //筛选数据
    _initScreenDada();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtils.appWhiteColor,
        body: LoadingContainer(
          isLoading: _loading,
          child: Padding(
            padding: EdgeInsets.only(top: PhoneMessage.statusBarHeight),
            child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: EasyRefresh(
                  key: _easyRefreshKey,
                  child: Column(
                    children: <Widget>[
                      //搜索视图
                      Padding(
                        padding: EdgeInsets.only(top: 1),
                      ),
                      SearchBar(
                        hideLeft: true,
                        inputBoxClick: _jumpToSearch,
                        speakClick: _jumpToSpeak,
                        hint: '搜索产品关键词',
                        isClear: isClear,
                        onChanged: _onChanged,
                        leftButtonClick: () {},
                      ),
                      //顶部视图
                      LocalNav(localNavList: localNavList),
                      Container(
                        height: 11,
                        color: ColorUtils.appWhiteColor,
                      ),
                      //广告视图
                      AdvertisingNav(advertisingNavList: advertisingNavList),
                      //更多视图
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ScreenMoreNav()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: ColorUtils.gradientEnd13Color,
                                    offset: Offset(3.0, 3.0),
                                    blurRadius: 3.0,
                                    spreadRadius: 1.0)
                              ]),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: ColorUtils.appWhiteColor,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(right: 18, left: 18),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '热门推荐',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Expanded(
                                        child: Container(),
                                        flex: 1,
                                      ),
                                      Text(
                                        '查看更多>>',
                                        style: TextStyle(
                                            color: ColorUtils
                                                .appTopAdvertisingTextColor,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ),
                      Offstage(
                        offstage: _isShowSearch ? true : false,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: PagingNav(
                            pagingRowNavList: pagingRowList,
                          ),
                        ),
                      ),
                      Offstage(
                        offstage: _isShowSearch ? false : true,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: PagingNav(
                            pagingRowNavList: searchRowList,
                          ),
                        ),
                      )
                    ],
                  ),
                  //视图刷新
                  onRefresh: () async {
                    await new Future.delayed(const Duration(seconds: 1), () {
                      setState(() {
                        //头部的四个按钮
                        _initTopFourBut();
                        //首页广告位
                        _initMainAdvertising();
                        //分页数据
                        _initMainPaging();
                        //筛选itme
                        _initScreen();
                        //筛选数据
                        _initScreenDada();
                        _loading=false;
                      });
                    });
                  },
                  //自定义刷新头部
                  refreshHeader: MaterialHeader(
                    key: _headerKey,
                  )),
            ),
          ),
        ));
  }

  _jumpToSearch() {}

  _jumpToSpeak() {}

  @override
  bool get wantKeepAlive => true;

  _onChanged(String text) async {
    if (text.isEmpty) {
      return;
    }
    try {
      Map<String, dynamic> resJson;
      final res = await HttpUtil.getInstance()
          .post(CommonCode.GET_INDEX_PRODUCT_SEARCH, data: {"name": text});
      if (res is String) {
        resJson = json.decode(res);
      } else if (res is Map<String, dynamic>) {
        resJson = res;
      } else {
        throw DioError(message: '数据解析错误');
      }
      var modelData = PagingModel.fromJson(resJson);
      searchRowList = modelData.rows;
    } catch (e) {
      print("-----" + e.toString());
    } finally {
      _isShowSearch = true;
      setState(() {});
    }
  }

  isClear() {
    setState(() {
      _isShowSearch = false;
    });
  }
}
