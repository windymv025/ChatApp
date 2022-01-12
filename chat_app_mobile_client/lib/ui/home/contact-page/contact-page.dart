import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:chat_app_mobile_client/provider/group/group-provider.dart';
import 'package:chat_app_mobile_client/provider/home/home-provider.dart';
import 'package:chat_app_mobile_client/ui/home/contact-page/tabview/tab-friend.dart';
import 'package:chat_app_mobile_client/ui/home/contact-page/tabview/tab-group.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    final GroupProvider groupProvider = Provider.of<GroupProvider>(context);
    final ContactProvider contactProvider =
        Provider.of<ContactProvider>(context);
    return RefreshIndicator(
        onRefresh: () async {
          await groupProvider.loadGroup();
          await contactProvider.reloadContacts();
        },
        child: buildTab(homeProvider.tabContactIndex));
  }

  Widget buildTab(int index) {
    if (index == 0) {
      return const TabFriend();
    } else {
      return const TabGroup();
    }
  }
}
