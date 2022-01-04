import 'package:chat_app_mobile_client/constants/assets.dart';
import 'package:chat_app_mobile_client/constants/styles.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/models/contact.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:chat_app_mobile_client/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestItem extends StatefulWidget {
  const RequestItem({Key? key, required this.contact}) : super(key: key);
  final Contact contact;
  @override
  _RequestItemState createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  @override
  Widget build(BuildContext context) {
    ContactProvider contactProvider = Provider.of<ContactProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: getImage(widget.contact.userRequested),
        ),
        title: Text(
          widget.contact.userRequested.name,
          style: titleStyle,
        ),
        subtitle: Text(widget.contact.userRequested.email),
        trailing: OutlinedButton(
          onPressed: () {
            contactProvider.acceptContact(widget.contact);
          },
          child: Text(S.current.accept),
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
