import 'dart:async';

import 'package:chat_app_mobile_client/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance

  static SharedPreferenceHelper? _instance;

  static SharedPreferenceHelper get instance {
    _instance ??= SharedPreferenceHelper._();
    return _instance!;
  }

  SharedPreferenceHelper._();
  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString(Preferences.authToken);
  }

  Future<bool> saveAuthToken(String authToken) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(Preferences.authToken, authToken);
  }

  Future<bool> removeAuthToken() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.remove(Preferences.authToken);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getBool(Preferences.isLoggedIn) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setBool(Preferences.isLoggedIn, value);
  }

  //profile:--------------------------------------------------------------------
  Future<bool> saveProfile(User profile) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(Preferences.profile, profile.toJson());
  }

  Future<User?> get profile async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    if (_sharedPreference.getString(Preferences.profile) == null) return null;
    return User.fromJson(_sharedPreference.getString(Preferences.profile)!);
  }

  Future<bool> removeProfile() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.remove(Preferences.profile);
  }

  //Password:-------------------------------------------------------------------
  Future<bool> savePassword(String password) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(Preferences.password, password);
  }

  Future<String?> get password async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString(Preferences.password);
  }

  Future<bool> removePassword() async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.remove(Preferences.password);
  }

  // Theme:------------------------------------------------------
  Future<bool> get isDarkMode async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getBool(Preferences.isDarkMode) ?? false;
  }

  Future<bool> changeBrightnessToDark(bool value) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setBool(Preferences.isDarkMode, value);
  }

  // Language:---------------------------------------------------
  Future<String?> get currentLanguage async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.getString(Preferences.currentLanguage);
  }

  Future<bool> changeLanguage(String language) async {
    SharedPreferences _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference.setString(Preferences.currentLanguage, language);
  }
}
