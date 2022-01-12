import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/provider/contact/contact-provider.dart';
import 'package:chat_app_mobile_client/ui/home/request-page/adapter/request-contact-adapter.dart';
import 'package:chat_app_mobile_client/ui/widgets/page/no_data_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    ContactProvider contactProvider = Provider.of<ContactProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        child: RequestContactAdapter(
          contacts: contactProvider.getRequestContacts(authProvider.profile),
        ),
      ),
    );
  }
}
