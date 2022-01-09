import 'package:chat_app_mobile_client/data/network/constants/endpoints.dart';

import '../../rest_client.dart';

class UserApi {
  final RestClient _restClient = RestClient.instance;
  Future<dynamic> searchUser(String keySearch) async {
    String? token = await _restClient.getToken();
    var res = await _restClient.post(
      Endpoints.search,
      params: {
        'keyword': keySearch,
      },
      headers: {
        'x-auth-token': token ?? '',
      },
    );
    return res;
  }
}
