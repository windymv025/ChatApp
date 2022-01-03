import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.watch<AuthProvider>();
    return Container(
      child: Text("Contact Page"),
    );
  }
}
