import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/constants/enums.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/models/group.dart';
import 'package:chat_app_mobile_client/provider/group/group-provider.dart';
import 'package:chat_app_mobile_client/provider/message/message-provider.dart';
import 'package:chat_app_mobile_client/ui/search/search-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupMessageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const GroupMessageAppBar({Key? key, required this.group}) : super(key: key);
  final Group group;
  @override
  _GroupMessageAppBarState createState() => _GroupMessageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

class _GroupMessageAppBarState extends State<GroupMessageAppBar> {
  @override
  Widget build(BuildContext context) {
    final GroupProvider groupProvider = Provider.of<GroupProvider>(context);
    final MessageProvider messageProvider =
        Provider.of<MessageProvider>(context);
    groupProvider.loadUsersInGroup(widget.group.id);
    return Container(
      padding: const EdgeInsets.only(top: 25),
      color: Theme.of(context).appBarTheme.backgroundColor,
      width: widget.preferredSize.width,
      height: widget.preferredSize.height + 20,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              messageProvider.inChatId = "";
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Row(
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
                      const SizedBox(height: 5),
                      Text(
                        "${groupProvider.users.length} ${S.of(context).members}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            onSelected: (value) {
              if (value == MenuMessageSetting.addNewMember) {
                Navigator.of(context).pushNamed(SearchScreen.routeName,
                    arguments: TypebodySearch.user);
              } else if (value == MenuMessageSetting.leaveGroup) {
                groupProvider.leaveGroup(widget.group.id);
                Navigator.pop(context);
              } else if (value == MenuMessageSetting.priority) {
                groupProvider.changePriority(widget.group.id).then((value) {
                  messageProvider.changeGroupPriority(widget.group.id);

                  if (messageProvider.currentPage == 0) {
                    messageProvider.getPriorityMessages();
                  } else {
                    messageProvider.getNormalMessages();
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.current.change_priority_success),
                  ));
                });
              }
            },
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
                ),
                PopupMenuItem(
                  value: MenuMessageSetting.priority,
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 10),
                      Text(S.current.change_priority),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
