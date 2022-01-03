import 'dart:convert';

import 'package:chat_app_mobile_client/models/contact.dart';

class Block {
  Block({
    required this.id,
    required this.user,
    required this.userBlocked,
    required this.blockedAt,
    required this.isRemoved,
    required this.updatedAt,
  });

  String id;
  Contact user;
  Contact userBlocked;
  DateTime blockedAt;
  bool isRemoved;
  DateTime updatedAt;

  factory Block.fromJson(String str) => Block.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Block.fromMap(Map<String, dynamic> json) => Block(
        id: json["_id"],
        user: Contact.fromMap(json["user"]),
        userBlocked: Contact.fromMap(json["user_blocked"]),
        blockedAt: DateTime.parse(json["blocked_at"]),
        isRemoved: json["is_removed"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "user": user.toMap(),
        "user_blocked": userBlocked.toMap(),
        "blocked_at": blockedAt.toIso8601String(),
        "is_removed": isRemoved,
        "updated_at": updatedAt.toIso8601String(),
      };
}
