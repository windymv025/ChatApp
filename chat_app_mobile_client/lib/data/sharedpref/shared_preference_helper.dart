import 'dart:async';

import 'package:chat_app_mobile_client/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  SharedPreferences? _sharedPreference;
  static SharedPreferenceHelper? _instance;

  static Future<SharedPreferenceHelper> get instance async {
    _instance ??= SharedPreferenceHelper._();
    return _instance!;
  }

  // constructor
  // SharedPreferenceHelper(this._sharedPreference?);
  SharedPreferenceHelper._() {
    _init();
  }

  _init() {
    SharedPreferences.getInstance().then((prefs) {
      _sharedPreference = prefs;
    });
  }

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference?.getString(Preferences.authToken);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference!.setString(Preferences.authToken, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference!.remove(Preferences.authToken);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference?.getBool(Preferences.isLoggedIn) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference!.setBool(Preferences.isLoggedIn, value);
  }

  //profile:--------------------------------------------------------------------
  Future<bool> saveProfile(User profile) async {
    return _sharedPreference!.setString(Preferences.profile, profile.toJson());
  }

  Future<User?> get profile async {
    if (_sharedPreference?.getString(Preferences.profile) == null) return null;
    return User.fromJson(_sharedPreference!.getString(Preferences.profile)!);
  }

  Future<bool> removeProfile() async {
    return _sharedPreference!.remove(Preferences.profile);
  }

  //Password:-------------------------------------------------------------------
  Future<bool> savePassword(String password) async {
    return _sharedPreference!.setString(Preferences.password, password);
  }

  Future<String?> get password async {
    return _sharedPreference?.getString(Preferences.password);
  }

  Future<bool> removePassword() async {
    return _sharedPreference!.remove(Preferences.password);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference?.getBool(Preferences.isDarkMode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference!.setBool(Preferences.isDarkMode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference?.getString(Preferences.currentLanguage);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference!.setString(Preferences.currentLanguage, language);
  }
}
