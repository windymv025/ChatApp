import 'package:chat_app_mobile_client/models/contact.dart';
import 'package:chat_app_mobile_client/ui/home/request-page/components/request-item.dart';
import 'package:chat_app_mobile_client/ui/widgets/page/no_data_page.dart';
import 'package:flutter/material.dart';

class RequestContactAdapter extends StatelessWidget {
  const RequestContactAdapter({Key? key, required this.contacts})
      : super(key: key);
  final List<Contact> contacts;
  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return const NoDataPage();
    }
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        return RequestItem(contact: contacts[index]);
      },
    );
  }
}
