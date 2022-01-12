import 'package:chat_app_mobile_client/provider/home/home-provider.dart';
import 'package:chat_app_mobile_client/ui/message/message-screen.dart';
import 'package:chat_app_mobile_client/ui/search/search-screen.dart';
import 'package:chat_app_mobile_client/ui/widgets/app-bar/appbar-widget/contact-app-bar.dart';
import 'package:chat_app_mobile_client/ui/widgets/app-bar/appbar-widget/group-message-appbar.dart';
import 'package:chat_app_mobile_client/ui/widgets/app-bar/appbar-widget/invidual-message-appbar.dart';
import 'package:chat_app_mobile_client/ui/widgets/app-bar/appbar-widget/request-app-bar.dart';
import 'package:chat_app_mobile_client/ui/widgets/app-bar/appbar-widget/setting-app-bar.dart';
import 'package:flutter/material.dart';

import 'appbar-widget/home-app-bar.dart';
import 'appbar-widget/search-app-bar.dart';

class AppBarFactory {
  static final Map<String, PreferredSizeWidget> _appBars = {
    HomeProvider.titles[0]: HomeAppBar(
      title: HomeProvider.titles[0],
    ),
    HomeProvider.titles[1]: ContactAppBar(
      title: HomeProvider.titles[1],
    ),
    HomeProvider.titles[2]: RequestAppBar(
      title: HomeProvider.titles[2],
    ),
    HomeProvider.titles[3]: const SettingAppBar(),
    SearchScreen.routeName: const SearchAppBar(),
  };

  PreferredSizeWidget getAppBar(String key, [dynamic argument]) {
    if (_appBars.containsKey(key)) {
      return _appBars[key]!;
    }

    if (argument != null) {
      if (key == MessageScreen.typeInvidual) {
        return InvidualMessageAppBar(user: argument);
      } else if (key == MessageScreen.typeGroup) {
        return GroupMessageAppBar(group: argument);
      }
    }
    return AppBar(
      title: Text(key),
    );
  }
}
