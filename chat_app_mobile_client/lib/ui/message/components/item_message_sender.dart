import 'dart:async';

import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/models/message.dart';
import 'package:chat_app_mobile_client/provider/authentication/auth-provider.dart';
import 'package:chat_app_mobile_client/utils/helper/function-helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ItemMessageSender extends StatefulWidget {
  const ItemMessageSender({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  _ItemMessageSenderState createState() => _ItemMessageSenderState();
}

class _ItemMessageSenderState extends State<ItemMessageSender> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color color = kMainBlueColor;
    AuthProvider authProvider = context.read<AuthProvider>();
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 5, left: 8),
              child: Text(
                  authProvider.profile != null
                      ? authProvider.profile!.name
                      : "",
                  style: const TextStyle(color: Colors.black))),
          Container(
            constraints:
                BoxConstraints(maxWidth: size.width * 0.6, minWidth: 120),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: color,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 40, top: 10, bottom: 30),
                    child: Text(
                      widget.message.content,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 7,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text(
                            getStringTime(widget.message.sentAt),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
