import 'package:chat_app_mobile_client/constants/assets.dart';
import 'package:chat_app_mobile_client/constants/styles.dart';
import 'package:chat_app_mobile_client/models/contact.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/ui/widgets/page/no_data_page.dart';
import 'package:flutter/material.dart';

class TabFriend extends StatelessWidget {
  const TabFriend({Key? key, required this.values}) : super(key: key);
  final List<Contact> values;
  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return const NoDataPage();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListView.builder(
        itemCount: values.length,
        padding: const EdgeInsets.symmetric(vertical: 5),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: getImage(values[index].userRequestedTo),
            ),
            title: Text(
              values[index].userRequestedTo.name,
              style: titleStyle,
            ),
            subtitle: Text(values[index].userRequestedTo.email),
          );
        },
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
