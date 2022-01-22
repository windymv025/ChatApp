import 'package:chat_app_mobile_client/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter/cupertino.dart';

class LanguageProfile extends ChangeNotifier {
  static const String codeVN = 'vi';
  static const String codeEN = 'en';
  Locale locale = const Locale(codeEN);

  LanguageProfile() {
    _loadlanguage();
  }
  _loadlanguage() async {
    String? currentLanguage =
        await SharedPreferenceHelper.instance.currentLanguage;
    if (currentLanguage == null) return;
    if (currentLanguage == codeVN) {
      locale = const Locale(codeVN);
    } else {
      locale = const Locale(codeEN);
    }
    notifyListeners();
  }

  void changeLanguage(String language) {
    if (language == codeVN) {
      locale = const Locale(codeVN);
    } else {
      locale = const Locale(codeEN);
    }

    SharedPreferenceHelper.instance.changeLanguage(language);
    notifyListeners();
  }
}
