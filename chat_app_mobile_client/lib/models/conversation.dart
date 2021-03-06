import 'package:chat_app_mobile_client/models/user.dart';

import 'group.dart';

class Conversation {
  Conversation({
    required this.id,
    required this.sender,
    this.receiver,
    this.group,
    required this.content,
    required this.type,
    required this.sentAt,
    required this.isRemoved,
    required this.isNotification,
  });

  String id;
  User sender;
  User? receiver;
  Group? group;
  String content;
  String type;
  DateTime sentAt;
  bool isRemoved;
  bool isNotification;

  factory Conversation.fromMap(Map<String, dynamic> json) => Conversation(
        id: json["_id"],
        sender: User.fromMap(json["sender"]),
        receiver:
            json["receiver"] == null ? null : User.fromMap(json["receiver"]),
        group: json["group"] == null ? null : Group.fromMap(json["group"]),
        content: json["content"],
        type: json["type"],
        sentAt: DateTime.parse(json["sent_at"]).toLocal(),
        isRemoved: json["is_removed"],
        isNotification: json["is_notification"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "sender": sender.toMap(),
        "receiver": receiver == null ? null : receiver!.toMap(),
        "group": group == null ? null : group!.toMap(),
        "content": content,
        "type": type,
        "sent_at": sentAt.toIso8601String(),
        "is_removed": isRemoved,
        "is_notification": isNotification,
      };
}
