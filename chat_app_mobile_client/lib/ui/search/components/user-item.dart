import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/constants/styles.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/provider/group/group-provider.dart';
import 'package:chat_app_mobile_client/provider/message/message-provider.dart';
import 'package:chat_app_mobile_client/utils/helper/function-helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserItem extends StatefulWidget {
  const UserItem({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {
  bool isAddGroup = false;
  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessageProvider>(context);
    final groupProvider = Provider.of<GroupProvider>(context);
    isAddGroup =
        groupProvider.users.where((e) => e.id == widget.user.id).isNotEmpty;
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: getImage(widget.user),
      ),
      title: Text(
        widget.user.name,
        style: titleStyle,
      ),
      subtitle: Text(widget.user.email),
      trailing: IconButton(
          icon: isAddGroup
              ? const Icon(Icons.check_circle_rounded, color: kMainBlueColor)
              : const Icon(Icons.person_add_alt_rounded),
          onPressed: () {
            if (!isAddGroup) {
              setState(() {
                isAddGroup = true;
              });
              groupProvider.addNewMemberToGroup(
                  messageProvider.inChatId, widget.user.id);
            }
          }),
    );
  }
}
