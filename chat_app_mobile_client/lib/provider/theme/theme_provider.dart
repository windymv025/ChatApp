import 'package:chat_app_mobile_client/constants/strings.dart';
import 'package:chat_app_mobile_client/constants/theme.dart';
import 'package:chat_app_mobile_client/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  static final Map<String, ThemeData> _themes = {
    kStringLightTheme: themeDataLight,
    kStringDarkTheme: themeDataDark,
  };
  late SharedPreferenceHelper _prefHelper;

  ThemeData _themeMode = _themes[kStringLightTheme]!;
  String typeName = kStringLightTheme;
  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    _prefHelper = SharedPreferenceHelper.instance;
    bool? isDark = await _prefHelper.isDarkMode;
    if (isDark == true) {
      typeName = kStringDarkTheme;
    } else {
      typeName = kStringLightTheme;
    }
    _themeMode = _themes[typeName]!;
    notifyListeners();
  }

  ThemeData get themeMode => _themeMode;

  void setThemeDark() async {
    typeName = kStringDarkTheme;
    _themeMode = _themes[typeName]!;
    await _prefHelper.changeBrightnessToDark(true);
    notifyListeners();
  }

  void setThemeLight() async {
    typeName = kStringLightTheme;
    _themeMode = _themes[typeName]!;
    await _prefHelper.changeBrightnessToDark(false);
    notifyListeners();
  }
}
