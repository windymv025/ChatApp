import 'package:chat_app_mobile_client/data/network/apis/contact/contact-api.dart';
import 'package:chat_app_mobile_client/data/network/apis/user/user-api.dart';
import 'package:chat_app_mobile_client/data/sharedpref/shared_preference_helper.dart';
import 'package:chat_app_mobile_client/models/contact.dart';
import 'package:chat_app_mobile_client/models/user-state/in-contact-user-state.dart';
import 'package:chat_app_mobile_client/models/user-state/new-user-state.dart';
import 'package:chat_app_mobile_client/models/user-state/request-user-sate.dart';
import 'package:chat_app_mobile_client/models/user-state/response-add-user-state.dart';
import 'package:chat_app_mobile_client/models/user-state/user-state.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/service/socket-service.dart';
import 'package:flutter/cupertino.dart';

class ContactProvider extends ChangeNotifier {
  final List<Contact> _contacts = [];
  final List<User> _searchContacts = [];
  final List<User> _currentUser = [];

  final ContactApi _contactApi = ContactApi();
  final UserApi _userApi = UserApi();
  User? _profile;

  late SocketService _socketService;

  List<Contact> get contacts => _contacts;
  List<User> get searchContacts => _searchContacts;
  List<User> get currentUser => _currentUser;

  List<Contact> getAcceptContacts(User? profile) {
    if (profile == null) return [];
    _profile ??= profile;
    final List<Contact> _acceptContacts = [];
    for (var item in _contacts) {
      if (item.isAccepted) {
        _acceptContacts.add(item);
        if (item.userRequested.id == profile.id) {
          item.userRequestedTo.state = InContactUserState();
        } else {
          item.userRequested.state = InContactUserState();
        }
      }
    }
    return _acceptContacts;
  }

  List<Contact> getRequestContacts(User? profile) {
    if (profile == null) return [];
    _profile ??= profile;
    final List<Contact> _respontContacts = [];
    for (var item in _contacts) {
      if (!item.isAccepted && item.userRequested.id != _profile!.id) {
        _respontContacts.add(item);
        item.userRequested.state = RequestUserState();
      }
    }
    return _respontContacts;
  }

  init() async {
    await loadContact();
    await getProfile();
    _socketService = SocketService.instance;
    _socketService.onIsAcceptedContact(handleIsAcceptedContact);
    _socketService.onIsAddedContact(handleIsAddedContact);
    _socketService.onIsRemovedContact(handleIsRemovedContact);
  }

  loadContact() async {
    _contacts.clear();
    var res = await _contactApi.getContacts();
    if (res != null && res is List) {
      for (var item in res) {
        var user = Contact.fromMap(item);
        _contacts.add(user);
      }
    }
    notifyListeners();
  }

  getProfile() async {
    var prefs = await SharedPreferenceHelper.instance;
    var _p = await prefs.profile;
    if (_p != null) {
      _profile = _p;
    }
  }

  handleIsAcceptedContact(data) {
    var contact = Contact.fromMap(data);
    if (_contacts.where((element) => element.id == contact.id).isNotEmpty) {
      var temp = _contacts.firstWhere((element) => element.id == contact.id);
      temp.isAccepted = contact.isAccepted;
      temp.userRequestedTo.state = InContactUserState();
      notifyListeners();
    }
  }

  handleIsAddedContact(data) {
    var contact = Contact.fromMap(data);
    if (_contacts.where((element) => element.id == contact.id).isEmpty) {
      contact.userRequested.state = ResponseAddUserState();
      _contacts.add(contact);
      notifyListeners();
    }
  }

  handleIsRemovedContact(data) {
    var contact = Contact.fromMap(data);
    if (_contacts.where((element) => element.id == contact.id).isNotEmpty) {
      _contacts.removeWhere((element) => element.id == contact.id);
      notifyListeners();
    }
  }

  void searchContact(String keyword, User? profile) async {
    if (profile == null) return;
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
      user.state.idContact = contacts.first.id;
    } else {
      user.state = NewUserState();
      user.state.idContact = user.id;
    }
    notifyListeners();
  }

  acceptContact(Contact contact) async {
    await _socketService.acceptContactEmit(contact.id);
    _contacts.firstWhere((element) => element.id == contact.id).isAccepted =
        true;
    notifyListeners();
  }

  userStateChange(User user) async {
    var type = user.onPress();
    switch (type) {
      case UserStateType.inContact:
        user.state = NewUserState();
        await removeContact(user.id);
        break;

      case UserStateType.newUser:
        user.state = RequestUserState();
        await addNewContact(user);
        break;

      case UserStateType.requestUser:
        user.state = NewUserState();
        await removeContact(user.id);
        break;

      case UserStateType.responseUser:
        user.state = InContactUserState();
        await acceptContactByUserId(user.id);
        break;

      default:
        break;
    }
    notifyListeners();
  }

  removeContact(String idUser) async {
    var contact = _contacts.firstWhere((element) =>
        element.userRequested.id == idUser ||
        element.userRequestedTo.id == idUser);
    await _socketService.removeContactEmit(contact.id);
    _contacts.removeWhere((element) => element.id == contact.id);
    notifyListeners();
  }

  addNewContact(User user) async {
    await _socketService.addContactEmit(user.id);
    await reloadContacts();
    notifyListeners();
  }

  acceptContactByUserId(String idUser) async {
    var contact = _contacts.where((element) =>
        element.userRequested.id == idUser ||
        element.userRequestedTo.id == idUser);
    if (contact.isNotEmpty) {
      await _socketService.acceptContactEmit(contact.first.id);
      _contacts
          .firstWhere((element) => element.id == contact.first.id)
          .isAccepted = true;
      notifyListeners();
    }
  }

  reloadContacts() async {
    _contacts.clear();
    var res = await _contactApi.getContacts();
    if (res != null && res is List) {
      for (var item in res) {
        var user = Contact.fromMap(item);
        _contacts.add(user);
      }
    }
    notifyListeners();
  }

  changePriority(String idUser) async {
    var contact = _contacts.where((element) =>
        element.userRequested.id == idUser ||
        element.userRequestedTo.id == idUser);
    if (contact.isNotEmpty) {
      var res = await _contactApi.changePriority(contact.first.id);
      if (res['message'] == null) {
        contact.first.isPriority = !contact.first.isPriority;
      }
    }

    notifyListeners();
  }

  void clearSearch() {
    _searchContacts.clear();
    notifyListeners();
  }

  void clean() {
    _contacts.clear();
    _searchContacts.clear();
    _profile = null;
    notifyListeners();
  }

  void loadCurrentUser() {
    _currentUser.clear();
    for (var i in _contacts) {
      if (i.userRequested.id == _profile?.id) {
        _currentUser.add(i.userRequestedTo);
      } else {
        _currentUser.add(i.userRequested);
      }
    }
  }
}
