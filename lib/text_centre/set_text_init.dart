
import 'package:the_fish_fly/text_centre/text_field_inn.dart';

class SetTextInit{
  static setTextInit(){
    TextFieldInn.addText("home", "首页", "home");
  }
  static updateLanguage(String language){
    TextFieldInn.language=language;
  }
}
