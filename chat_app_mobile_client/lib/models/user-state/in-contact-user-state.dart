import 'package:flutter/material.dart';

import 'user-state.dart';

class InContactUserState extends UserState {
  @override
  Widget getIcon() {
    return const Icon(
      Icons.person_remove,
      color: Colors.red,
    );
  }

  @override
  UserStateType onPress() {
    return UserStateType.inContact;
  }
}
