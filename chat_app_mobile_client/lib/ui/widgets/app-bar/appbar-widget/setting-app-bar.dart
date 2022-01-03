import 'package:chat_app_mobile_client/provider/home/home-provider.dart';
import 'package:flutter/material.dart';

class SettingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SettingAppBar({Key? key}) : super(key: key);
  @override
  Size get preferredSize => AppBar().preferredSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Center(
      child: Text(
        HomeProvider.titles[3],
      ),
    ));
  }
}
