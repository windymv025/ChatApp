import 'package:flutter/material.dart';

abstract class UserState {
  Widget getIconButton() {
    return IconButton(icon: Icon(getIconData()), onPressed: () => onPress());
  }

  void onPress();
  IconData getIconData();
}
