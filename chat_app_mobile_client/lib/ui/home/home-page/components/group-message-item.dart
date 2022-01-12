import 'dart:async';

import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/constants/strings.dart';
import 'package:chat_app_mobile_client/constants/styles.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/models/group.dart';
import 'package:chat_app_mobile_client/models/main-message.dart';
import 'package:chat_app_mobile_client/provider/message/message-provider.dart';
import 'package:chat_app_mobile_client/ui/message/message-screen.dart';
import 'package:chat_app_mobile_client/utils/helper/function-helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class GroupMessageItem extends StatefulWidget {
  const GroupMessageItem({Key? key, required this.value}) : super(key: key);
  final MainMessage value;
  @override
  _GroupMessageItemState createState() => _GroupMessageItemState();
}

class _GroupMessageItemState extends State<GroupMessageItem> {
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
    Group? group = widget.value.group;
    final MessageProvider messageProvider = context.read();
    return ListTile(
      onTap: () {
        messageProvider.loadGroupMessage(group!.id);
        Navigator.of(context)
            .pushNamed(MessageScreen.routeName, arguments: group);
      },
      leading: Container(
        decoration: BoxDecoration(
          border: Border.all(color: kMainBlueColor, width: 2),
          shape: BoxShape.circle,
          color: kMainBlueColor,
        ),
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade100,
          child: Text(
              "${group?.name[0].toUpperCase()}${group?.name[group.name.length - 1].toUpperCase()}"),
        ),
      ),
      title: Text(
        group!.name,
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
    if (widget.value.type == 'text') {
      return widget.value.content;
    }
    return S.current.image;
  }
}
