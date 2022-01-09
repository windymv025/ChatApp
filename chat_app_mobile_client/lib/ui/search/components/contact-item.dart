import 'package:chat_app_mobile_client/constants/assets.dart';
import 'package:chat_app_mobile_client/constants/styles.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:chat_app_mobile_client/ui/message/message-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactItem extends StatefulWidget {
  const ContactItem({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(MessageScreen.routeName, arguments: widget.user),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: getImage(widget.user),
          ),
          title: Text(
            widget.user.name,
            style: titleStyle,
          ),
          subtitle: Text(widget.user.email),
          trailing: widget.user.state.getIconButton(),
        ),
      ),
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
