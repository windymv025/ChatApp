import 'package:chat_app_mobile_client/constants/assets.dart';
import 'package:chat_app_mobile_client/constants/styles.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/ui/message/message-screen.dart';
import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({Key? key, required this.friend}) : super(key: key);
  final User friend;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context)
          .pushNamed(MessageScreen.routeName, arguments: friend),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: getImage(friend),
      ),
      title: Text(
        friend.name,
        style: titleStyle,
      ),
      subtitle: Text(friend.email),
    );
  }

  ImageProvider? getImage(User profile) {
    if (profile.imageUrl.isNotEmpty) {
      return NetworkImage(profile.imageUrl);
    } else {
      return const AssetImage(Assets.assetsImagesUserIcon);
    }
  }
}
