import 'package:flutter/material.dart';

abstract class UserState {
  String? idContact;
  UserStateType onPress();
  Widget getIcon();
}

enum UserStateType { inContact, newUser, requestUser, responseUser }
