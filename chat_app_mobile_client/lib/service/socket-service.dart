import 'package:chat_app_mobile_client/data/sharedpref/shared_preference_helper.dart';
import 'package:chat_app_mobile_client/service/event.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  final String baseUlr = "https://server-chat-ts.herokuapp.com/";
  static SocketService? _instance;
  static SocketService get instance => _instance ??= SocketService._();

  Socket? socket;
  String idProfile = "";

  SocketService._() {
    SharedPreferenceHelper.instance
        .then((value) => value.profile.then((value) => idProfile = value!.id));

    if (socket != null) {
      socket?.disconnect();
    }

    socket = io(baseUlr, OptionBuilder().setTransports(['websocket']).build());
    socket?.connect();
    socket?.onConnect((_) {
      // ignore: avoid_print
      print("connected");
      joinAppEmit(idProfile);
    });
  }

  joinAppEmit(String id) {
    return socket?.emit(Event.joinApp, id);
  }

  disconnect() {
    return socket?.disconnect();
  }

  sendMessageEmit(String content, {String? groupId, String? userId}) {
    return socket?.emit(Event.sendMessage, {
      "id_sender": idProfile,
      "content": content,
      "id_receiver": userId,
      "id_group": groupId,
    });
  }

  addNewMemberEmit(String userId, String groupId) {
    return socket?.emit(Event.addNewMember, {
      "id_new_member": userId,
      "id_user_added": idProfile,
      "id_group": groupId,
    });
  }

  joinGroupEmit(String groupId) {
    return socket?.emit(Event.joinGroup, {
      "id_group": groupId,
    });
  }

  leaveGroupEmit(String groupId) {
    return socket?.emit(Event.leaveGroup, {
      "id_user_leave": idProfile,
      "id_group": groupId,
    });
  }

  addContactEmit(String userId) {
    return socket?.emit(Event.addContact, {
      "id_user": idProfile,
      "id_user_contact": userId,
    });
  }

  removeContactEmit(String idContact) {
    return socket?.emit(Event.removeContact, {
      "id_user": idProfile,
      "id_contact": idContact,
    });
  }

  acceptContactEmit(String idContact) {
    return socket?.emit(Event.acceptContact, {
      "id_user": idProfile,
      "id_contact": idContact,
    });
  }

  onListOnlineUserListener(callback) {
    return socket?.on(Event.listUserOnline, callback);
  }

  onReceiveMessage(callback) {
    return socket?.on(Event.recieveMessage, callback);
  }

  onIsAddedToGroup(callback) {
    return socket?.on(Event.isAddedToGroup, callback);
  }

  onIsAddedContact(callback) {
    return socket?.on(Event.isAddedContact, callback);
  }

  onIsRemovedContact(callback) {
    return socket?.on(Event.isRemoveContact, callback);
  }

  onIsAcceptedContact(callback) {
    return socket?.on(Event.isAcceptContact, callback);
  }
}
