import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:chat_app_mobile_client/ui/search/adpter/search-adapter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactSearchBody extends StatelessWidget {
  const ContactSearchBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ContactProvider provider = Provider.of<ContactProvider>(context);
    return SearchAdpter(
      users: provider.searchContacts,
    );
  }
}
