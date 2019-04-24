
 class  TextFieldInn {
  static var _localizedValues = new Map<String, LanguageInn>();
  static var language = "ch";

 static String getText(String key) {
    if (_localizedValues.containsKey(key)) {
      LanguageInn languageInn =_localizedValues[key];
      if (language == "ch") {
        return languageInn.ch;
      } else {
        return languageInn.en;
      }
    } else {
      return "";
    }
  }

  static addText(String key, String ch, String en) {
    var languageInn = LanguageInn();
    languageInn.ch = ch;
    languageInn.en = en;
    _localizedValues[key] = languageInn;
  }
}

class LanguageInn {
  String ch;
  String en;
}
