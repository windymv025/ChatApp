import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/constants/styles.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton(
      {Key? key,
      this.onPress,
      required this.icon,
      required this.title,
      this.child})
      : super(key: key);
  final GestureTapCallback? onPress;
  final Widget icon;
  final String title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    double defaultSize = 10;
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultSize),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 1),
                blurStyle: BlurStyle.outer),
          ],
          border: Border.all(
            color: kMainBlueColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: defaultSize,
          vertical: defaultSize,
        ),
        padding: child != null
            ? EdgeInsets.fromLTRB(defaultSize * 2, 3, defaultSize * 2, 3)
            : EdgeInsets.fromLTRB(defaultSize * 2, defaultSize * 1.5,
                defaultSize * 2, defaultSize * 1.5),
        child: SafeArea(
          child: Row(
            children: <Widget>[
              icon,
              SizedBox(width: defaultSize * 2),
              Text(
                title,
                style: titleStyle,
              ),
              const Spacer(),
              child ?? Container(),
              const SizedBox(width: 5),
              Icon(
                Icons.arrow_forward_ios,
                size: defaultSize * 1.6,
              )
            ],
          ),
        ),
      ),
    );
  }
}
