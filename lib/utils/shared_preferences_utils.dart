
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/model/login_model.dart';

class Sp {

  static setLoginMessage(LoginModel modelData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.setString(CommonCode.My_TOKENT,(null==modelData.token)?"":"Bearer " +modelData.token);
     preferences.setString(CommonCode.USER_NAME,(null==modelData.items[0].title)?"":modelData.items[0].title);
     preferences.setString(CommonCode.USER_HEAD,(null==modelData.items[0].img)?"":modelData.items[0].img);
     preferences.setString(CommonCode.USER_PHONE,(null==modelData.items[0].phone)?"":modelData.items[0].phone);
  }


  static clearLoginMessage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.setString(CommonCode.My_TOKENT,null);
     preferences.setString(CommonCode.USER_NAME,null);
     preferences.setString(CommonCode.USER_HEAD,null);
     preferences.setString(CommonCode.USER_PHONE,null);
  }

  static userMessageInput() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    CommonCode.My_TOKENTInfo=preferences.getString(CommonCode.My_TOKENT);
    CommonCode.USER_NAMEInfo=preferences.getString(CommonCode.USER_NAME);
    CommonCode.USER_PHONEInfo=preferences.getString(CommonCode.USER_PHONE);
    CommonCode.USER_HEADInfo=preferences.getString(CommonCode.USER_HEAD);
  }

}
