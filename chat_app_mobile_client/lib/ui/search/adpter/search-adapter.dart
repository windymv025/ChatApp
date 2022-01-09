import 'package:chat_app_mobile_client/models/contact.dart';
import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/ui/search/components/contact-item.dart';
import 'package:chat_app_mobile_client/ui/widgets/page/no_data_page.dart';
import 'package:flutter/material.dart';

class SearchAdpter extends StatelessWidget {
  const SearchAdpter({Key? key, required this.users}) : super(key: key);
  final List<User> users;
  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const NoDataPage();
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return ContactItem(user: users[index]);
      },
    );
  }
}
