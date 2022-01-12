import 'package:chat_app_mobile_client/models/main-message.dart';
import 'package:chat_app_mobile_client/ui/home/home-page/components/group-message-item.dart';
import 'package:chat_app_mobile_client/ui/home/home-page/components/invidual-message-item.dart';
import 'package:chat_app_mobile_client/ui/widgets/page/no_data_page.dart';
import 'package:flutter/material.dart';

class MainMessageAdapter extends StatelessWidget {
  const MainMessageAdapter({Key? key, required this.values}) : super(key: key);
  final List<MainMessage> values;
  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return const NoDataPage();
    }
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (context, index) => buildMessageItem(values[index]),
    );
  }

  buildMessageItem(MainMessage value) {
    if (value.group != null) {
      return GroupMessageItem(value: value);
    } else {
      return InvidualMessageItem(value: value);
    }
  }
}
