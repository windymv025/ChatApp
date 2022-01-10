import 'package:chat_app_mobile_client/data/network/apis/message/message-api.dart';
import 'package:chat_app_mobile_client/models/main-message.dart';
import 'package:chat_app_mobile_client/models/message.dart';
import 'package:flutter/cupertino.dart';

class MessageProvider extends ChangeNotifier {
  final List<Message> _messages = [];
  final List<MainMessage> _mainMessages = [];

  final MessageApi _messageApi = MessageApi();

  List<Message> get messages {
    return _messages;
  }

  List<MainMessage> get mainMessages {
    _mainMessages.sort((a, b) => b.sentAt.compareTo(a.sentAt));
    return _mainMessages;
  }

  void loadMainMessages() async {
    _mainMessages.clear();
    var res = await _messageApi.getMainMessage();
    for (var item in res) {
      _mainMessages.add(MainMessage.fromMap(item));
    }
    notifyListeners();
  }

  void loadGroupMessage(String groupId) {
    _messages.clear();
    _messageApi.getGroupMessages(groupId).then((res) {
      for (var item in res) {
        _messages.add(Message.fromMap(item));
      }
      notifyListeners();
    });
  }

  void loadInvidualMessage(String userId) {
    _messages.clear();
    _messageApi.getInvidualMessages(userId).then((res) {
      for (var item in res) {
        _messages.add(Message.fromMap(item));
      }
      notifyListeners();
    });
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
}
