import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:chat_app_mobile_client/ui/search/components/user-item.dart';
import 'package:chat_app_mobile_client/ui/widgets/page/no_data_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSearchBody extends StatefulWidget {
  const UserSearchBody({Key? key}) : super(key: key);

  @override
  _UserSearchBodyState createState() => _UserSearchBodyState();
}

class _UserSearchBodyState extends State<UserSearchBody> {
  @override
  Widget build(BuildContext context) {
    final ContactProvider provider = Provider.of<ContactProvider>(context);
    provider.loadCurrentUser();
    final users = provider.searchContacts.isEmpty
        ? provider.currentUser
        : provider.searchContacts;
    if (users.isEmpty) {
      return const NoDataPage();
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return UserItem(user: users[index]);
      },
    );
  }
}
