import 'package:chat_app_mobile_client/data/network/constants/endpoints.dart';

import '../../rest_client.dart';

class MessageApi {
  final RestClient _restClient = RestClient.instance;
  Future<dynamic> getMainMessage() async {
    String? token = await _restClient.getToken();
    final response = await _restClient.get(
      Endpoints.getMainMessage,
      headers: {
        'x-auth-token': token ?? '',
      },
    );
    return response;
  }

  Future<dynamic> getGroupMessages(String groupId) async {
    String? token = await _restClient.getToken();
    final response = await _restClient.get(
      Endpoints.getMainMessage,
      params: {
        'id_group': groupId,
      },
      headers: {
        'x-auth-token': token ?? '',
      },
    );
    return response;
  }

  Future<dynamic> getInvidualMessages(String userId) async {
    String? token = await _restClient.getToken();
    final response = await _restClient.get(
      Endpoints.getMainMessage,
      params: {
        'id_user_contact': userId,
      },
      headers: {
        'x-auth-token': token ?? '',
      },
    );
    return response;
  }
}
