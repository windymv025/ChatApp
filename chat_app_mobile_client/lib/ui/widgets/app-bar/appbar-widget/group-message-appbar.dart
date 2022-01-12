import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/constants/enums.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/models/group.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/circle_avatar_button.dart';
import 'package:chat_app_mobile_client/utils/helper/function-helper.dart';
import 'package:flutter/material.dart';

class GroupMessageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const GroupMessageAppBar({Key? key, required this.group}) : super(key: key);
  final Group group;
  @override
  _GroupMessageAppBarState createState() => _GroupMessageAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _GroupMessageAppBarState extends State<GroupMessageAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kMainBlueColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: kMainBlueColor, width: 2),
              shape: BoxShape.circle,
              color: kMainBlueColor,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: Text(
                  "${widget.group.name[0].toUpperCase()}${widget.group.name[widget.group.name.length - 1].toUpperCase()}"),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.group.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_vert_rounded),
          onSelected: (value) {},
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: MenuMessageSetting.addNewMember,
                child: Row(
                  children: [
                    const Icon(Icons.person_add_alt_1_rounded,
                        color: kMainBlueColor),
                    const SizedBox(width: 10),
                    Text(S.current.add_group_member),
                  ],
                ),
              ),
              PopupMenuItem(
                value: MenuMessageSetting.leaveGroup,
                child: Row(
                  children: [
                    const Icon(Icons.logout_outlined, color: Colors.red),
                    const SizedBox(width: 10),
                    Text(S.current.leave_group),
                  ],
                ),
              )
            ];
          },
        ),
      ],
    );
  }
}
