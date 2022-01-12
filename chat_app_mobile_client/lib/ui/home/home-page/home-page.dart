import 'package:chat_app_mobile_client/models/contact.dart';
import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:chat_app_mobile_client/provider/home/home-provider.dart';
import 'package:chat_app_mobile_client/provider/message/message-provider.dart';
import 'package:chat_app_mobile_client/ui/home/home-page/adapter/main-message-adapter.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    MessageProvider messageProvider = context.watch<MessageProvider>();
    HomeProvider homeProvider = context.watch<HomeProvider>();
    ContactProvider contactProvider = context.watch();
    return RefreshIndicator(
        onRefresh: () async {
          await messageProvider.loadMainMessages();
          messageProvider.setContacts(contactProvider.contacts);
          if (homeProvider.tabHomeIndex == 0) {
            messageProvider.getPriorityMessages();
          } else {
            messageProvider.getNormalMessages();
          }
        },
        child: MainMessageAdapter(values: messageProvider.mainMessages));
  }
}
