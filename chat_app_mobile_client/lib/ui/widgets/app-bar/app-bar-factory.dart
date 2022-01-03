import 'package:chat_app_mobile_client/provider/home/home-provider.dart';
import 'package:chat_app_mobile_client/ui/widgets/app-bar/appbar-widget/setting-app-bar.dart';
import 'package:flutter/material.dart';

import 'appbar-widget/home-app-bar.dart';

class AppBarFactory {
  static final Map<String, PreferredSizeWidget> _appBars = {
    HomeProvider.titles[0]: HomeAppBar(
      title: HomeProvider.titles[0],
    ),
    HomeProvider.titles[1]: HomeAppBar(
      title: HomeProvider.titles[1],
    ),
    HomeProvider.titles[2]: HomeAppBar(
      title: HomeProvider.titles[2],
    ),
    HomeProvider.titles[3]: const SettingAppBar(),
  };

  PreferredSizeWidget getAppBar(String key) {
    if (_appBars.containsKey(key)) {
      return _appBars[key]!;
    }
    return AppBar(
      title: Text(key),
    );
  }
}
