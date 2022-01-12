import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/constants/enums.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/ui/widgets/button/circle_avatar_button.dart';
import 'package:chat_app_mobile_client/utils/helper/function-helper.dart';
import 'package:flutter/material.dart';

class InvidualMessageAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const InvidualMessageAppBar({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _InvidualMessageAppBarState createState() => _InvidualMessageAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _InvidualMessageAppBarState extends State<InvidualMessageAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kMainBlueColor,
      title: Row(
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
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_vert_rounded),
          onSelected: (value) {},
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: MenuMessageSetting.block,
                child: Row(
                  children: [
                    const Icon(Icons.block, color: Colors.red),
                    const SizedBox(width: 10),
                    Text(S.current.block),
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
