import 'package:chat_app_mobile_client/constants/styles.dart';
import 'package:chat_app_mobile_client/models/group.dart';
import 'package:chat_app_mobile_client/provider/group/group-provider.dart';
import 'package:chat_app_mobile_client/ui/message/message-screen.dart';
import 'package:chat_app_mobile_client/ui/widgets/page/no_data_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabGroup extends StatelessWidget {
  const TabGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GroupProvider groupProvider = Provider.of<GroupProvider>(context);
    if (groupProvider.groups.isEmpty) {
      return const NoDataPage();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListView.builder(
        itemCount: groupProvider.groups.length,
        addAutomaticKeepAlives: true,
        padding: const EdgeInsets.symmetric(vertical: 5),
        itemBuilder: (BuildContext context, int index) {
          Group value = groupProvider.groups[index];
          return ListTile(
            onTap: () => Navigator.of(context)
                .pushNamed(MessageScreen.routeName, arguments: value),
            leading: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey.shade100,
              child: Text(
                  "${value.name[0].toUpperCase()}${value.name[value.name.length - 1].toUpperCase()}"),
            ),
            title: Text(
              value.name,
              style: titleStyle,
            ),
          );
        },
      ),
    );
  }
}
