import 'package:chat_app_mobile_client/service/event.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  final String baseUlr = "https://server-chat-ts.herokuapp.com/";
  static SocketService? _instance;
  static SocketService get instance => _instance ??= SocketService._();

  Socket? socket;
  String idProfile = "";

  SocketService._() {
    if (socket != null) {
      socket?.disconnect();
    }

    socket = io(baseUlr, OptionBuilder().setTransports(['websocket']).build());
  }

  void connectAndListen(String id) {
    idProfile = id;
    socket?.connect();
    socket?.onConnect((_) {
      joinAppEmit(id);
    });
  }

  void joinAppEmit(String id) {
    socket?.emit(Event.joinApp, id);
  }

  void onListOnlineUserListener(callback) {
    socket?.on(Event.listUserOnline, callback);
  }

  void disconnect() {
    socket?.disconnect();
  }

  void sendMessageEmit(String content, {String? groupId, String? userId}) {
    socket?.emit(Event.sendMessage, {
      "id_sender": idProfile,
      "content": content,
      "id_receiver": userId,
      "id_group": groupId,
    });
  }

  void onReceiveMessage(callback) {
    socket?.on(Event.recieveMessage, callback);
  }

  void addNewMemberEmit(String userId, String groupId) {
    socket?.emit(Event.addNewMember, {
      "id_new_member": userId,
      "id_user_added": idProfile,
      "id_group": groupId,
    });
  }

  void onIsAddedToGroup(callback) {
    socket?.on(Event.isAddedToGroup, callback);
  }

  void joinGroupEmit(String groupId) {
    socket?.emit(Event.joinGroup, {
      "id_group": groupId,
    });
  }

  void leaveGroupEmit(String groupId) {
    socket?.emit(Event.leaveGroup, {
      "id_user_leave": idProfile,
      "id_group": groupId,
    });
  }

  void addContactEmit(String userId) {
    socket?.emit(Event.addContact, {
      "id_user": idProfile,
      "id_user_contact": userId,
    });
  }

  void onIsAddedContact(callback) {
    socket?.on(Event.isAddedContact, callback);
  }

  void removeContactEmit(String idContact) {
    socket?.emit(Event.removeContact, {
      "id_user": idProfile,
      "id_contact": idContact,
    });
  }

  void onIsRemovedContact(callback) {
    socket?.on(Event.isRemoveContact, callback);
  }

  void acceptContactEmit(String idContact) {
    socket?.emit(Event.acceptContact, {
      "id_user": idProfile,
      "id_contact": idContact,
    });
  }

  void onIsAcceptedContact(callback) {
    socket?.on(Event.isAcceptContact, callback);
  }
}
