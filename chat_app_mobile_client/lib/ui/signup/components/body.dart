import 'package:chat_app_mobile_client/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'already_have_account.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: 100,
                    child: SvgPicture.asset(Assets.assetsIconsIconLaunch)),
                const SizedBox(
                  height: 25,
                ),
                const SignUpForm(),
                const SizedBox(
                  height: 15,
                ),
                const AlreadyHaveAccount(),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
