import 'package:chat_app_mobile_client/data/network/apis/contact/contact-api.dart';
import 'package:chat_app_mobile_client/data/network/apis/user/user-api.dart';
import 'package:chat_app_mobile_client/data/sharedpref/shared_preference_helper.dart';
import 'package:chat_app_mobile_client/models/contact.dart';
import 'package:chat_app_mobile_client/models/user-state/in-contact-user-state.dart';
import 'package:chat_app_mobile_client/models/user-state/new-user-state.dart';
import 'package:chat_app_mobile_client/models/user-state/request-user-sate.dart';
import 'package:chat_app_mobile_client/models/user-state/response-add-user-state.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:flutter/cupertino.dart';

class ContactProvider extends ChangeNotifier {
  final List<Contact> _contacts = [];
  final List<User> _searchContacts = [];

  final ContactApi _contactApi = ContactApi();
  final UserApi _userApi = UserApi();
  User? _profile;

  List<Contact> get contacts => _contacts;
  List<User> get searchContacts => _searchContacts;

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
      if (item.isAccepted) {
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

  void acceptContact(Contact contact) {
    _contactApi.acceptContact(contact.id);
    _contacts.firstWhere((element) => element.id == contact.id).isAccepted =
        true;
    notifyListeners();
  }

  void searchContact(String keyword, User profile) async {
    _profile = profile;
    _searchContacts.clear();
    notifyListeners();
    try {
      var res = await _userApi.searchUser(keyword) as List<dynamic>;

      for (var item in res) {
        var user = User.fromMap(item);
        if (_searchContacts.where((element) => element.id == user.id).isEmpty) {
          _searchContacts.add(user);
          addStateUser(user.id);
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('Can not search contact');
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchContacts.clear();
    notifyListeners();
  }

  void addContact(User user) {}

  void addStateUser(String id) {
    var contact = _contacts.where((element) =>
        element.userRequested.id == id || element.userRequestedTo.id == id);
    var user = _searchContacts.firstWhere((element) => element.id == id);

    if (contact.isNotEmpty) {
      if (contact.first.isAccepted == true) {
        user.state = InContactUserState();
      } else {
        if (contact.first.userRequested.id == _profile?.id) {
          user.state = RequestUserState();
        } else {
          user.state = ResponseAddUserState();
        }
      }
    } else {
      user.state = NewUserState();
    }
    notifyListeners();
  }
}
