import 'package:chat_app_mobile_client/data/network/constants/endpoints.dart';

import '../../rest_client.dart';

class ContactApi {
  final RestClient _restClient = RestClient.instance;
  Future<dynamic> getContacts() async {
    String? token = await _restClient.getToken();
    final response = await _restClient.get(
      Endpoints.contacts,
      headers: {
        'x-auth-token': token ?? '',
      },
    );
    return response;
  }

  Future<dynamic> addNewContact(String idContact) async {
    String? token = await _restClient.getToken();
    final response = await _restClient.post(Endpoints.addContact, headers: {
      'x-auth-token': token ?? '',
    }, body: {
      "id_user_contact": idContact,
    });
    return response;
  }

  Future<dynamic> acceptContact(String idContact) async {
    String? token = await _restClient.getToken();
    final response = await _restClient.post(Endpoints.acceptContact, headers: {
      'x-auth-token': token ?? '',
    }, body: {
      "id_contact": idContact,
    });
    return response;
  }

  Future<dynamic> removeContact(String idContact) async {
    String? token = await _restClient.getToken();
    final response = await _restClient.post(Endpoints.removeContact, headers: {
      'x-auth-token': token ?? '',
    }, body: {
      "id_contact": idContact,
    });
    return response;
  }

  Future<dynamic> changePriority(String idContact) async {
    String? token = await _restClient.getToken();
    final response = await _restClient.post(Endpoints.changePriority, headers: {
      'x-auth-token': token ?? '',
    }, body: {
      "id_contact": idContact,
    });
    return response;
  }
}
