import 'dart:async';

import 'package:chat_app_mobile_client/models/user.dart';
import 'package:chat_app_mobile_client/provider/message/message-provider.dart';
import 'package:chat_app_mobile_client/ui/widgets/app-bar/app-bar-factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/body_chat.dart';

class MessageScreen extends StatelessWidget {
  static const String routeName = "/message";
  static const String typeInvidual = "individual";
  static const String typeGroup = "group";
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MessageProvider messageProvider =
        Provider.of<MessageProvider>(context);
    dynamic argument = ModalRoute.of(context)!.settings.arguments;
    String? type;

    if (argument is User) {
      messageProvider.receiverUser = argument;
      messageProvider.receiverGroup = null;
      type = MessageScreen.typeInvidual;
    } else {
      messageProvider.receiverUser = null;
      messageProvider.receiverGroup = argument;
      type = MessageScreen.typeGroup;
    }
    messageProvider.inChatId = argument.id;
    return Scaffold(
      appBar: getAppBar(argument),
      body: BodyChat(
        type: type,
      ),
    );
  }

  getAppBar(argument) {
    final factory = AppBarFactory();
    if (argument is User) {
      return factory.getAppBar(MessageScreen.typeInvidual, argument);
    } else {
      return factory.getAppBar(MessageScreen.typeGroup, argument);
    }
  }
}
