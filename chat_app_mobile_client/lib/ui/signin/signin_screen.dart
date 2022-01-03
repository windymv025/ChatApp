import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'components/signin_body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).sign_in),
        centerTitle: false,
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: SignInBody(),
      ),
    );
  }
}
