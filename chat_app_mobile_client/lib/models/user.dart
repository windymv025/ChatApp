import 'dart:convert';

import 'package:chat_app_mobile_client/data/network/apis/contact/contact-api.dart';
import 'package:chat_app_mobile_client/models/user-state/in-contact-user-state.dart';
import 'package:chat_app_mobile_client/models/user-state/new-user-state.dart';
import 'package:chat_app_mobile_client/models/user-state/request-user-sate.dart';
import 'package:chat_app_mobile_client/models/user-state/response-add-user-state.dart';
import 'package:chat_app_mobile_client/models/user-state/user-state.dart';
import 'package:flutter/material.dart';

class User {
  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.imageUrl,
      required this.createdAt,
      this.password,
      this.isPriority = false});

  String id;
  String email;
  String name;
  String? password;
  String imageUrl;
  DateTime createdAt;
  bool isPriority;
  UserState state = RequestUserState();

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        imageUrl: json["image_url"],
        createdAt: DateTime.parse(json["created_at"]),
        isPriority: json["is_priority"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "email": email,
        "name": name,
        "image_url": imageUrl,
        "created_at": createdAt.toIso8601String(),
        "is_priority": isPriority,
      };

  UserStateType onPress() {
    var type = state.onPress();
    return type;
  }

  Widget getIcon() {
    return state.getIcon();
  }
}
