import 'package:chat_app_mobile_client/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter/cupertino.dart';

class LanguageProfile extends ChangeNotifier {
  static const String codeVN = 'vi';
  static const String codeEN = 'en';

  late SharedPreferenceHelper _prefHelper;
  Locale locale = const Locale(codeEN);

  LanguageProfile() {
    _loadlanguage();
  }

  void _loadlanguage() async {
    _prefHelper = await SharedPreferenceHelper.instance;

    if (_prefHelper.currentLanguage == null) return;
    if (_prefHelper.currentLanguage == codeVN) {
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
    _prefHelper.changeLanguage(language);

    notifyListeners();
  }
}
