import 'dart:convert';

import 'package:chat_app_mobile_client/models/user-state/request-user-sate.dart';
import 'package:chat_app_mobile_client/models/user-state/user-state.dart';
import 'package:flutter/material.dart';

class User {
  User({
    required this.id,
    required this.email,
    required this.name,
    required this.imageUrl,
    required this.createdAt,
    this.password,
  });

  String id;
  String email;
  String name;
  String? password;
  String imageUrl;
  DateTime createdAt;
  UserState state = RequestUserState();

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]).toLocal(),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "email": email,
        "name": name,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
      };

  UserStateType onPress() {
    var type = state.onPress();
    return type;
  }

  Widget getIcon() {
    return state.getIcon();
  }
}
