import 'dart:convert';

import 'group.dart';
import 'user.dart';

class Message {
  Message({
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

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json["_id"],
        sender: User.fromMap(json["sender"]),
        receiver:
            json["receiver"] != null ? User.fromMap(json["receiver"]) : null,
        group: json["group"] != null ? Group.fromMap(json["group"]) : null,
        content: json["content"],
        type: json["type"],
        sentAt: DateTime.parse(json["sent_at"]).toLocal(),
        isRemoved: json["is_removed"],
        isNotification: json["is_notification"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "sender": sender.toMap(),
        "receiver": receiver,
        "group": group?.toMap(),
        "content": content,
        "type": type,
        "sent_at": sentAt.toIso8601String(),
        "is_removed": isRemoved,
        "is_notification": isNotification,
      };
}
