import 'package:chat_app_mobile_client/constants/enums.dart';
import 'package:chat_app_mobile_client/generated/intl/messages_en.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:chat_app_mobile_client/provider/message/message-provider.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/circle_avatar_button.dart';
import 'package:chat_app_mobile_client/utils/helper/function-helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class InvidualMessageAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const InvidualMessageAppBar({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _InvidualMessageAppBarState createState() => _InvidualMessageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

class _InvidualMessageAppBarState extends State<InvidualMessageAppBar> {
  @override
  Widget build(BuildContext context) {
    ContactProvider contactProvider = context.read<ContactProvider>();
    MessageProvider messageProvider = context.read<MessageProvider>();
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
                CircleAvatarButton(
                  image: getImage(widget.user),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.user.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        widget.user.email,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
            onSelected: (value) {
              if (value == MenuMessageSetting.priority) {
                contactProvider.changePriority(widget.user.id).then((value) {
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
                  value: MenuMessageSetting.priority,
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 10),
                      Text(S.current.change_priority),
                    ],
                  ),
                ),
                // PopupMenuItem(
                //   value: MenuMessageSetting.block,
                //   child: Row(
                //     children: [
                //       const Icon(Icons.block, color: Colors.red),
                //       const SizedBox(width: 10),
                //       Text(S.current.block),
                //     ],
                //   ),
                // )
              ];
            },
          ),
        ],
      ),
    );
  }
}
