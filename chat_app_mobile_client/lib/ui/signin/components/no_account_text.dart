import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/ui/signup/sign_up_screen.dart';
import 'package:flutter/material.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${S.current.dont_have_account} ",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        InkWell(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            S.current.sign_up,
            style: const TextStyle(
                color: Color(0xff248EEF),
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
