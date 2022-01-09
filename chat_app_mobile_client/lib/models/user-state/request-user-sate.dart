import 'package:chat_app_mobile_client/models/user-state/user-state.dart';
import 'package:flutter/material.dart';

class RequestUserState extends UserState {
  @override
  Widget getIcon() {
    return const Icon(Icons.person_add_disabled);
  }

  @override
  UserStateType onPress() {
    return UserStateType.requestUser;
  }
}
