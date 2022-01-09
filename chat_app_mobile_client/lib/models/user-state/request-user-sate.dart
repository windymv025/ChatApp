import 'package:chat_app_mobile_client/models/user-state/user-state.dart';
import 'package:flutter/material.dart';

class RequestUserState extends UserState {
  @override
  IconData getIconData() {
    return Icons.person_add_disabled;
  }

  @override
  void onPress() {
    // TODO: implement onPress
  }
}
