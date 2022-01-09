import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/models/user-state/user-state.dart';
import 'package:flutter/material.dart';

class ResponseAddUserState extends UserState {
  @override
  Widget getIcon() {
    return const Icon(
      Icons.check_circle_outline_rounded,
      color: kMainBlueColor,
    );
  }

  @override
  UserStateType onPress() {
    return UserStateType.responseUser;
  }
}
