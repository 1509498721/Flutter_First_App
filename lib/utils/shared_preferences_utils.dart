
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_fish_fly/common/common_code.dart';
import 'package:the_fish_fly/model/login_model.dart';

class Sp {

  static setLoginMessage(LoginModel modelData) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.setString(CommonCode.My_TOKENT,(null==modelData.token)?null:"Bearer " +modelData.token.toString());
     preferences.setString(CommonCode.USER_NAME,(null==modelData.items[0].title)?null:modelData.items[0].title.toString());
     preferences.setString(CommonCode.USER_HEAD,(null==modelData.items[0].img)?null:modelData.items[0].img.toString());
     preferences.setString(CommonCode.USER_PHONE,(null==modelData.items[0].phone)?null:modelData.items[0].phone.toString());
     preferences.setString(CommonCode.USER_ID,(null==modelData.items[0].id)?null:modelData.items[0].id.toString());
     preferences.setString(CommonCode.USER_SOURCE,(null==modelData.items[0].frendSource)?null:modelData.items[0].frendSource.toString());
  }


  static clearLoginMessage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
     preferences.setString(CommonCode.My_TOKENT,null);
     preferences.setString(CommonCode.USER_NAME,null);
     preferences.setString(CommonCode.USER_HEAD,null);
     preferences.setString(CommonCode.USER_PHONE,null);
     preferences.setString(CommonCode.USER_ID,null);
     preferences.setString(CommonCode.USER_SOURCE,null);

  }

  static userMessageInput() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    CommonCode.My_TOKENTInfo=preferences.getString(CommonCode.My_TOKENT);
    CommonCode.USER_NAMEInfo=preferences.getString(CommonCode.USER_NAME);
    CommonCode.USER_PHONEInfo=preferences.getString(CommonCode.USER_PHONE);
    CommonCode.USER_HEADInfo=preferences.getString(CommonCode.USER_HEAD);
    CommonCode.USER_IDInfo=preferences.getString(CommonCode.USER_ID);
    CommonCode.USER_SOURCEInfo=preferences.getString(CommonCode.USER_SOURCE);
  }

}
