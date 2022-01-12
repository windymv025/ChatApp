import 'package:chat_app_mobile_client/data/network/apis/message/message-api.dart';
import 'package:chat_app_mobile_client/data/sharedpref/shared_preference_helper.dart';
import 'package:chat_app_mobile_client/models/contact.dart';
import 'package:chat_app_mobile_client/models/group.dart';
import 'package:chat_app_mobile_client/models/main-message.dart';
import 'package:chat_app_mobile_client/models/message.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/service/socket-service.dart';
import 'package:flutter/cupertino.dart';

class MessageProvider extends ChangeNotifier {
  final List<Message> _messages = [];
  final List<MainMessage> _mainMessages = [];
  final List<MainMessage> _currentMesage = [];
  final List<Contact> _contacts = [];

  final MessageApi _messageApi = MessageApi();

  User? _profile;
  SocketService? _socketService;
  String inChatId = "";
  User? receiverUser;
  Group? receiverGroup;
  int currentPage = 0;

  List<Message> get messages {
    return _messages;
  }

  List<MainMessage> get mainMessages {
    _currentMesage.sort((a, b) => b.sentAt.compareTo(a.sentAt));
    return _currentMesage;
  }

  void setContacts(List<Contact> contacts) {
    _contacts.clear();
    _contacts.addAll(contacts);
    notifyListeners();
  }

  void getPriorityMessages() {
    _currentMesage.clear();
    _currentMesage.addAll(_mainMessages
        .where((element) => checkIsPriorityContact(element, _contacts)));
    notifyListeners();
  }

  void getNormalMessages() {
    _currentMesage.clear();
    _currentMesage.addAll(_mainMessages
        .where((element) => checkIsNormalContact(element, _contacts)));
    notifyListeners();
  }

  init() async {
    await loadMainMessages();
    await getProfile();
    _socketService = SocketService.instance;
    _socketService?.onReceiveMessage(handelReceiveMessage);
    _socketService?.onIsAddedToGroup(handelIsAddedToGroup);
  }

  getProfile() async {
    var prefs = await SharedPreferenceHelper.instance;
    var _p = await prefs.profile;
    if (_p != null) {
      _profile = _p;
    }
  }

  handelIsAddedToGroup(data) {
    loadMainMessages();
  }

  handelReceiveMessage(data) {
    if (data != null) {
      var message = MainMessage.fromMap(data);
      if (message.sender?.id == inChatId || message.group?.id == inChatId) {
        var newMessage = Message(
            id: "",
            sender: message.sender!,
            content: message.content,
            type: message.type,
            sentAt: message.sentAt,
            isRemoved: message.isRemoved,
            isNotification: message.isNotification);
        _messages.add(newMessage);
      }
      if (message.sender?.id != _profile?.id) {
        updateMessage(message);
      }
    }
    notifyListeners();
  }

  void updateMessage(MainMessage message) {
    var mainMessage = _mainMessages.where((element) =>
        element.receiver?.id == message.sender?.id ||
        element.group?.id == message.group?.id);
    if (mainMessage.isNotEmpty) {
      mainMessages.first.content = message.content;
      mainMessages.first.sentAt = message.sentAt;
      mainMessages.first.isRemoved = message.isRemoved;
      mainMessages.first.isNotification = message.isNotification;
      mainMessages.first.type = message.type;
      mainMessages.first.sender = message.sender;
      mainMessages.first.notify();
    }
  }

  loadMainMessages() async {
    _mainMessages.clear();
    var res = await _messageApi.getMainMessage();
    for (var item in res) {
      _mainMessages.add(MainMessage.fromMap(item));
    }
    notifyListeners();
  }

  sendMessage(String content, {String? groupId, String? userId}) async {
    await _socketService?.sendMessageEmit(content,
        groupId: groupId, userId: userId);

    if (groupId != null) {
      var mainMessage =
          _mainMessages.firstWhere((element) => element.group?.id == groupId);
      mainMessage.content = content;
      mainMessage.sentAt = DateTime.now();
      mainMessage.isNotification = false;
      mainMessage.isRemoved = false;
    } else {
      var mainMessageList =
          _mainMessages.where((element) => element.receiver?.id == userId);
      if (mainMessageList.isNotEmpty) {
        mainMessageList.first.content = content;
        mainMessageList.first.sentAt = DateTime.now();
        mainMessageList.first.isNotification = false;
        mainMessageList.first.isRemoved = false;
      } else {
        _mainMessages.add(MainMessage(
            id: "",
            content: content,
            type: "text",
            sentAt: DateTime.now(),
            isRemoved: false,
            isNotification: false,
            sender: _profile,
            receiver: receiverUser,
            group: receiverGroup));
      }
    }

    _messages.add(Message(
        id: "",
        sender: _profile!,
        content: content,
        type: "text",
        sentAt: DateTime.now(),
        isRemoved: false,
        isNotification: false));
    notifyListeners();
  }

  loadGroupMessage(String groupId) async {
    _messages.clear();
    var res = await _messageApi.getGroupMessages(groupId);
    for (var item in res) {
      _messages.add(Message.fromMap(item));
    }
    notifyListeners();
  }

  loadInvidualMessage(String userId) async {
    _messages.clear();
    var res = await _messageApi.getInvidualMessages(userId);
    for (var item in res) {
      _messages.add(Message.fromMap(item));
    }
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }

  void clear() {
    _messages.clear();
    _mainMessages.clear();
    notifyListeners();
  }

  bool checkIsPriorityContact(MainMessage element, List<Contact> contacts) {
    return (element.group?.isPriority == true) ||
        (element.sender?.id == _profile?.id &&
            checkHaveUserInContact(element.receiver, contacts) &&
            checkUserIsPriority(element.receiver, contacts)) ||
        (element.sender?.id != _profile?.id &&
            checkHaveUserInContact(element.sender, contacts) &&
            checkUserIsPriority(element.sender, contacts));
  }

  bool checkIsNormalContact(MainMessage element, List<Contact> contacts) {
    if (element.group?.isPriority == true) return false;
    return (element.sender?.id == _profile?.id &&
            (!checkHaveUserInContact(element.receiver, contacts) ||
                !checkUserIsPriority(element.receiver, contacts))) ||
        (element.sender?.id != _profile?.id &&
            (!checkHaveUserInContact(element.sender, contacts) ||
                !checkUserIsPriority(element.sender, contacts)));
  }

  bool checkHaveUserInContact(User? receiver, List<Contact> contacts) {
    return contacts
        .where((element) =>
            element.userRequested.id == receiver?.id ||
            element.userRequestedTo.id == receiver?.id)
        .isNotEmpty;
  }

  bool checkUserIsPriority(User? receiver, List<Contact> contacts) {
    return contacts
        .where((element) =>
            element.userRequested.id == receiver?.id ||
            element.userRequestedTo.id == receiver?.id)
        .first
        .isPriority;
  }
}
