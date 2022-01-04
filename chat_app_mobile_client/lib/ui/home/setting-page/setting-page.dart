import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/provider/home/home-provider.dart';
import 'package:chat_app_mobile_client/ui/home/setting-page/components/settings_button.dart';
import 'package:chat_app_mobile_client/ui/profile/profile-screen.dart';
import 'package:chat_app_mobile_client/ui/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/setting_dropdown_button.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.read();
    HomeProvider homeProvider = context.read();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          SettingsButton(
            onPress: () =>
                Navigator.pushNamed(context, ProfileScreen.routeName),
            icon: const Icon(
              Icons.person_rounded,
              color: kMainBlueColor,
            ),
            title: S.of(context).account,
          ),
          // SettingsButton(
          //   icon: const Icon(
          //     Icons.vpn_key_rounded,
          //     color: kMainBlueColor,
          //   ),
          //   title: S.of(context).change_password,
          // ),
          SettingsButton(
              onPress: null,
              icon: const Icon(
                Icons.language_rounded,
                color: kMainBlueColor,
              ),
              title: S.of(context).languages,
              child: const SettingLanguageDropdownButton()),
          SettingsButton(
              onPress: null,
              icon: const Icon(
                Icons.light_sharp,
                color: kMainBlueColor,
              ),
              title: S.of(context).theme,
              child: const SettingThemeDropdownButton()),
          SettingsButton(
            onPress: () {
              homeProvider.pageIndex = 0;
              authProvider.logout();
              Navigator.pushReplacementNamed(context, SignInScreen.routeName);
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: kMainBlueColor,
            ),
            title: S.of(context).logout,
          ),
        ],
      ),
    );
  }
}
