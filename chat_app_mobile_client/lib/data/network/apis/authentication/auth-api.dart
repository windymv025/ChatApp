import 'package:chat_app_mobile_client/data/network/constants/endpoints.dart';
import 'package:chat_app_mobile_client/data/sharedpref/shared_preference_helper.dart';
import 'package:chat_app_mobile_client/models/contact.dart';

import '../../rest_client.dart';

class AuthApi {
  final RestClient _restClient = RestClient.instance;
  Future<dynamic> login(String email, String password) async {
    final response = await _restClient.post(Endpoints.login, body: {
      'email': email,
      'password': password,
    });
    return response;
  }

  Future<dynamic> register(String email, String password, String name) async {
    final response = await _restClient.post(Endpoints.register, body: {
      'email': email,
      'password': password,
      'name': name,
    });

    return response;
  }

  Future<dynamic> auth() async {
    SharedPreferenceHelper sharedPref = await SharedPreferenceHelper.instance;
    String? token = await sharedPref.authToken;
    final response = await _restClient.post(
      Endpoints.auth,
      headers: {
        'x-auth-token': token ?? '',
      },
    );
    return response;
  }

  Future<dynamic> changeProfile(String name, String password) async {
    SharedPreferenceHelper sharedPref = await SharedPreferenceHelper.instance;
    String? token = await sharedPref.authToken;
    final response = await _restClient.post(
      Endpoints.changeProfile,
      headers: {
        'x-auth-token': token ?? '',
      },
      body: {
        'name': name,
        'password': password,
      },
    );
    return response;
  }
}
