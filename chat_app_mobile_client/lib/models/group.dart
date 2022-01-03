import 'dart:convert';

import 'package:chat_app_mobile_client/models/user.dart';

class Group {
  Group({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.isDeleted,
    required this.joinedAt,
    this.leftAt,
    required this.userAdded,
    required this.isAdmin,
  });

  String id;
  String name;
  DateTime createdAt;
  bool isDeleted;
  DateTime joinedAt;
  DateTime? leftAt;
  User userAdded;
  bool isAdmin;

  factory Group.fromJson(String str) => Group.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Group.fromMap(Map<String, dynamic> json) => Group(
        id: json["_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        isDeleted: json["is_deleted"],
        joinedAt: DateTime.parse(json["joined_at"]),
        leftAt: json["left_at"],
        userAdded: User.fromMap(json["user_added"]),
        isAdmin: json["is_admin"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "is_deleted": isDeleted,
        "joined_at": joinedAt.toIso8601String(),
        "left_at": leftAt,
        "user_added": userAdded.toMap(),
        "is_admin": isAdmin,
      };
}
