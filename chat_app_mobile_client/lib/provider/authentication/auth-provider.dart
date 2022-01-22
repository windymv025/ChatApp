import 'dart:convert';
import 'dart:io';

import 'package:chat_app_mobile_client/data/network/apis/authentication/auth-api.dart';
import 'package:chat_app_mobile_client/data/sharedpref/shared_preference_helper.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  File? imageFile;

  AuthProvider() {
    _init();
  }

  User? _profile;
  User? get profile => _profile;
  AuthApi authApi = AuthApi();
  String message = "";

  Future<bool> login(String email, String password) async {
    var passHash = md5Hash(password);
    var res = await authApi.login(email, passHash) as Map;
    if (res.containsKey("user")) {
      _profile = User.fromMap(res["user"]);
      _profile?.password = password;
      await saveToken(res["access_token"]);
      await saveProfile(password);
      notifyListeners();
      return true;
    } else {
      message = res["message"];
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password, String name) async {
    var passHash = md5Hash(password);
    var res = await authApi.register(email, passHash, name) as Map;
    if (res.containsKey("user")) {
      _profile = User.fromMap(res["user"]);
      _profile?.password = password;
      await saveProfile(password);
      notifyListeners();

      return login(email, password);
    } else {
      message = res["message"];
      notifyListeners();
      return false;
    }
  }

  Future<bool> auth() async {
    var res = await authApi.auth() as Map;
    if (res.containsKey("user")) {
      _profile = User.fromMap(res["user"]);
      notifyListeners();
      return true;
    } else {
      message = res["message"];
      notifyListeners();

      return false;
    }
  }

  saveProfile(String password) async {
    var prefs = SharedPreferenceHelper.instance;
    await prefs.removeProfile();
    await prefs.removePassword();
    await prefs.saveProfile(_profile!);
    await prefs.savePassword(password);
  }

  saveToken(String token) async {
    var prefs = SharedPreferenceHelper.instance;
    await prefs.removeAuthToken();
    await prefs.saveAuthToken(token);
  }

  loadProfile() async {
    var prefs = SharedPreferenceHelper.instance;
    var _profileTemp = await prefs.profile;
    var passwordTemp = await prefs.password;
    if (_profileTemp != null && passwordTemp != null) {
      _profile = _profileTemp;
      _profile?.password = passwordTemp;
    } else {
      _profile = User(
          id: "",
          name: "",
          email: "",
          createdAt: DateTime.now(),
          imageUrl: '',
          password: "");
    }
    notifyListeners();
  }

  resetProfile() async {
    var prefs = SharedPreferenceHelper.instance;
    await prefs.removeProfile();
  }

  void logout() async {
    var prefs = SharedPreferenceHelper.instance;
    await prefs.removeProfile();
    await prefs.removeAuthToken();
    notifyListeners();
  }

  String md5Hash(String password) {
    // return password;
    var content = utf8.encode(password);
    var digest = md5.convert(content);
    return digest.toString();
  }

  void _init() {
    loadProfile();
  }

  Future<bool> updateProfile() async {
    var passHash = md5Hash(_profile!.password!);
    // ignore: avoid_print
    print(_profile?.name);
    var req = await authApi.changeProfile(_profile!.name, passHash);
    if (req != null) {
      saveProfile(_profile!.password!);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> changePassword(String newPassword) async {
    var passHash = md5Hash(newPassword);
    var req = await authApi.changeProfile(_profile!.name, passHash);
    if (req != null) {
      _profile?.password = newPassword;
      saveProfile(_profile!.password!);
      notifyListeners();
      return true;
    }
    return false;
  }

  void clean() {
    imageFile = null;
    message = "";
    notifyListeners();
  }
}
