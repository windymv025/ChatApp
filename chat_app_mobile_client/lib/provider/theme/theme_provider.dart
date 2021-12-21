import 'package:chat_app_mobile_client/constants/strings.dart';
import 'package:chat_app_mobile_client/constants/theme.dart';
import 'package:chat_app_mobile_client/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  SharedPreferenceHelper? _prefHelper;

  ThemeData _themeMode = themeDataLight;
  String typeName = kStringLightTheme;
  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    var prefs = await SharedPreferences.getInstance();
    _prefHelper = SharedPreferenceHelper(prefs);

    if (_prefHelper?.isDarkMode == true) {
      _themeMode = themeDataDark;
      typeName = kStringDarkTheme;
    } else {
      _themeMode = themeDataLight;
      typeName = kStringLightTheme;
    }
    notifyListeners();
  }

  ThemeData get themeMode => _themeMode;

  void setThemeDark() async {
    _themeMode = themeDataDark;
    typeName = kStringDarkTheme;
    await _prefHelper?.changeBrightnessToDark(true);
    notifyListeners();
  }

  void setThemeLight() async {
    _themeMode = themeDataLight;
    typeName = kStringLightTheme;
    await _prefHelper?.changeBrightnessToDark(false);
    notifyListeners();
  }
}
