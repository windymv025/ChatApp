import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/ui/widgets/app-bar/app-bar-factory.dart';
import 'package:flutter/material.dart';

import 'components/body_profile.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarFactory().getAppBar(S.current.account),
      body: const BodyProfile(),
    );
  }
}
