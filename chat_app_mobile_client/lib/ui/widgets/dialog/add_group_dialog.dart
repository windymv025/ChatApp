import 'package:chat_app_mobile_client/constants/dimens.dart';
import 'package:chat_app_mobile_client/constants/styles.dart';
import 'package:chat_app_mobile_client/generated/l10n.dart';
import 'package:chat_app_mobile_client/provider/group/group-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddGroupDialog extends StatefulWidget {
  const AddGroupDialog({Key? key}) : super(key: key);

  @override
  _AddGroupDialogState createState() => _AddGroupDialogState();
}

class _AddGroupDialogState extends State<AddGroupDialog> {
  String name = "";
  @override
  Widget build(BuildContext context) {
    GroupProvider provider = Provider.of<GroupProvider>(context);
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      title: Text(
        S.current.create_group,
        overflow: TextOverflow.clip,
        softWrap: true,
        style: const TextStyle(
            fontSize: textSizePageName, fontWeight: FontWeight.bold),
      ),
      content: TextFormField(
        keyboardType: TextInputType.name,
        autofocus: false,
        maxLines: 1,
        textCapitalization: TextCapitalization.sentences,
        onChanged: (value) => name = value,
        decoration: InputDecoration(
          label: Text(S.current.name_group),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            provider.createGroup(name);
            Navigator.of(context).pop();
          },
          child: const Text('OK', style: chipStyleOn),
          style: defaultButtonStyle,
        ),
        OutlinedButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: Text(S.current.cancel),
        ),
      ],
    );
  }
}
