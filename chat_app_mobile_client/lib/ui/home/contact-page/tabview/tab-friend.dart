import 'package:chat_app_mobile_client/models/contact.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:chat_app_mobile_client/ui/home/contact-page/tabview/friend-factory/friend-factory.dart';
import 'package:chat_app_mobile_client/ui/widgets/page/no_data_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class TabFriend extends StatelessWidget {
  const TabFriend({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.read<AuthProvider>();
    ContactProvider contactProvider = context.watch<ContactProvider>();
    FriendFactory friendFactory = FriendFactory();
    List<Contact> values =
        contactProvider.getAcceptContacts(authProvider.profile);
    if (values.isEmpty) {
      return const NoDataPage();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListView.builder(
        itemCount: values.length,
        padding: const EdgeInsets.symmetric(vertical: 5),
        itemBuilder: (BuildContext context, int index) {
          return friendFactory.getFriendItem(
              values[index], authProvider.profile);
        },
      ),
    );
  }
}
