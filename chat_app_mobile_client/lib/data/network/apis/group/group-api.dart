import 'package:chat_app_mobile_client/data/network/constants/endpoints.dart';

import '../../rest_client.dart';

class GroupApi {
  final RestClient _restClient = RestClient.instance;
  Future<dynamic> getGroups() async {
    String? token = await _restClient.getToken();
    var res = await _restClient.get(
      Endpoints.getGroups,
      headers: {
        'x-auth-token': token ?? '',
      },
    );
    return res;
  }

  Future<dynamic> getAllMemberGroup(String idGroup) async {
    String? token = await _restClient.getToken();
    var res = await _restClient.get(Endpoints.getGroupMembers, headers: {
      'x-auth-token': token ?? '',
    }, params: {
      'id_group': idGroup,
    });
    return res;
  }

  Future<dynamic> createGroup(String name) async {
    String? token = await _restClient.getToken();
    var res = await _restClient.post(Endpoints.createGroup, headers: {
      'x-auth-token': token ?? '',
    }, body: {
      'group_name': name,
    });
    return res;
  }

  Future<dynamic> addNewMemberInGroup(String idUser, String idGroup) async {
    String? token = await _restClient.getToken();
    var res = await _restClient.post(Endpoints.addGroupMember, headers: {
      'x-auth-token': token ?? '',
    }, body: {
      'id_group': idGroup,
      'id_new_user': idUser,
    });
    return res;
  }

  Future<dynamic> leaveGroup(String idGroup) async {
    String? token = await _restClient.getToken();
    var res = await _restClient.get(Endpoints.leaveGroup, headers: {
      'x-auth-token': token ?? '',
    }, params: {
      'id_group': idGroup,
    });
    return res;
  }
}
