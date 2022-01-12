import 'dart:async';

import 'package:chat_app_mobile_client/constants/strings.dart';
import 'package:chat_app_mobile_client/constants/styles.dart';
import 'package:chat_app_mobile_client/models/main-message.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/provider/message/message-provider.dart';
import 'package:chat_app_mobile_client/ui/message/message-screen.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/circle_avatar_button.dart';
import 'package:chat_app_mobile_client/utils/helper/function-helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class InvidualMessageItem extends StatefulWidget {
  const InvidualMessageItem({Key? key, required this.value}) : super(key: key);
  final MainMessage value;
  @override
  _InvidualMessageItemState createState() => _InvidualMessageItemState();
}

class _InvidualMessageItemState extends State<InvidualMessageItem> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.read<AuthProvider>();
    User? user = widget.value.sender?.id != authProvider.profile.id
        ? widget.value.sender
        : widget.value.receiver;
    final MessageProvider messageProvider = context.read();
    return ListTile(
      onTap: () {
        messageProvider.loadInvidualMessage(user!.id);
        Navigator.of(context)
            .pushNamed(MessageScreen.routeName, arguments: user);
      },
      leading: CircleAvatarButton(
        image: getImage(user!),
      ),
      title: Text(
        user.name,
        style: titleStyle,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              getMessage(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text("$dot${getStringTime(widget.value.sentAt)}"),
        ],
      ),
    );
  }

  String getMessage() {
    return widget.value.content;
  }
}
