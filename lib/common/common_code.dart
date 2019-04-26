

import 'package:the_fish_fly/model/home_screen_model.dart';
import 'package:the_fish_fly/model/screen_model.dart';

class CommonCode {
  static final String VERSIONS_CODE = "1.0.0";
  static final int SUCCESS_CODE = 200;
  static final String BASE_URL = "http://yef.miaojiedao.cn/"; //baseUrl
  static final String UPDATE_APP = "https://raw.githubusercontent.com/AriesHoo/FastLib/master/apk/___"; //查询APP是否有最新版本
  static final String POST_GET_GOOD_LIST = "Goods/getGoodsList"; //查询产品信息
  static final String POST_GET_PHONE_SMS = "admin/smsPhone"; //获取验证码
  static final String POST_ADMIN_LOGIN = "admin/login"; //输入验证码并登陆
  static final String GET_INDEX_TOP_ITEM = "APP/getAttributelist"; //获取首页顶部四个分类
  static final String GET_NOTICE_REQUEST_LIST = "APP/getNoticelist"; //获取公告列表
  static final String GET_INDEX_PRODUCT = "APP/getGoodList"; //首页公告精选
  static final String GET_INDEX_PRODUCT_SEARCH = "APP/getGoodesNameAndroid"; //首页搜索
  static final String GET_APP_TYPE_LIST = "app/MoneyList"; //首页贷款分类列表
  static final String GET_USER_INFO = "app/selectUser"; //获取用户信息
  static final String GET_PAGE_GOODS_LIST = "APP/getPageGoodsList"; //分页获取首页list
  static final String POST_PAGE_SELECTDETAIL = "goodsDetail/selectDetail"; //商品详情
  static final String POST_VERSION_SELECTDETAIL = "versionUpgrade/selectVersion"; //版本更新

  static final String POST_GET_WEIXIN = "APP/getWeixin"; //获取微信公众号
  static final String POST_GET_QQ = "APP/getQQ"; //获取QQ客服

  static final String My_TOKENT='myToken';
  static final String USER_NAME='myName';
  static final String USER_PHONE='myPhone';
  static final String USER_HEAD='myHead';
  static final String USER_ID='myId';
  static final String USER_SOURCE='mySource';


  static  String My_TOKENTInfo="";
  static  String USER_NAMEInfo="";
  static  String USER_PHONEInfo="";
  static  String USER_HEADInfo="";
  static  String USER_IDInfo="";
  static  String USER_SOURCEInfo="";

  static  ScreenModel screenModel;  //筛选
  static  List<HomeScreem> homeScreem;  //筛选

}
