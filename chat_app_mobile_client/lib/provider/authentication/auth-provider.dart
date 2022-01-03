import 'dart:convert';

import 'package:chat_app_mobile_client/data/network/apis/authentication/auth-api.dart';
import 'package:chat_app_mobile_client/data/sharedpref/shared_preference_helper.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _init();
  }

  late User profile;
  AuthApi authApi = AuthApi();
  String message = "";

  Future<bool> login(String email, String password) async {
    var passHash = md5Hash(password);
    var res = await authApi.login(email, passHash) as Map;
    if (res.containsKey("user")) {
      profile = User.fromMap(res["user"]);

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
      profile = User.fromMap(res["user"]);
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

  Future<bool> auth() async {
    var res = await authApi.auth() as Map;
    if (res.containsKey("user")) {
      profile = User.fromMap(res["user"]);
      notifyListeners();
      return true;
    } else {
      message = res["message"];
      notifyListeners();

      return false;
    }
  }

  Future<bool> loginAgain() async {
    var prefs = await SharedPreferenceHelper.instance;
    var p = await prefs.profile;
    if (p != null) {
      String email = p.email;
      String password = await prefs.password ?? "";

      return await login(email, password);
    }

    return false;
  }

  saveProfile(String password) async {
    var prefs = await SharedPreferenceHelper.instance;
    await prefs.saveProfile(profile);
    await prefs.savePassword(password);
  }

  saveToken(String token) async {
    var prefs = await SharedPreferenceHelper.instance;
    await prefs.saveAuthToken(token);
  }

  loadProfile() async {
    var prefs = await SharedPreferenceHelper.instance;
    var profileTemp = await prefs.profile;
    if (profileTemp != null) {
      profile = profileTemp;
      notifyListeners();
    }
  }

  resetProfile() async {
    var prefs = await SharedPreferenceHelper.instance;
    await prefs.removeProfile();
  }

  String md5Hash(String password) {
    // return password;
    var content = utf8.encode(password);
    var digest = md5.convert(content);
    return digest.toString();
  }

  void _init() {}
}
