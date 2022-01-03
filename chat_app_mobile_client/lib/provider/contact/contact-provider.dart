import 'package:chat_app_mobile_client/data/network/apis/contact/contact-api.dart';
import 'package:chat_app_mobile_client/data/sharedpref/shared_preference_helper.dart';
import 'package:chat_app_mobile_client/models/contact.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:flutter/cupertino.dart';

class ContactProvider extends ChangeNotifier {
  final List<Contact> _contacts = [];
  final ContactApi _contactApi = ContactApi();
  User? _profile;

  List<Contact> get contacts => _contacts;

  void loadContact() async {
    _contacts.clear();
    var res = await _contactApi.getContacts();
    if (res != null) {
      for (var item in res) {
        _contacts.add(Contact.fromMap(item));
      }
      notifyListeners();
    }
  }

  List<Contact> getAcceptContacts(User profile) {
    _profile ??= profile;
    final List<Contact> _acceptContacts = [];
    for (var item in _contacts) {
      if (item.isAccepted && item.userRequested.id == _profile!.id) {
        _acceptContacts.add(item);
      }
    }
    return _acceptContacts;
  }

  List<Contact> getRequestContacts(User profile) {
    _profile ??= profile;
    final List<Contact> _respontContacts = [];
    for (var item in _contacts) {
      if (!item.isAccepted && item.userRequested.id != _profile!.id) {
        _respontContacts.add(item);
      }
    }
    return _respontContacts;
  }

  void getProfile() async {
    var prefs = await SharedPreferenceHelper.instance;
    var _p = await prefs.profile;
    if (_p != null) {
      _profile = _p;
    }
  }
}
