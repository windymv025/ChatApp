import 'dart:async';

import 'package:chat_app_mobile_client/constants/colors.dart';
import 'package:chat_app_mobile_client/models/message.dart';
import 'package:chat_app_mobile_client/utils/helper/function-helper.dart';
import 'package:flutter/material.dart';

class ItemMessageReceiver extends StatefulWidget {
  const ItemMessageReceiver({Key? key, required this.message})
      : super(key: key);

  final Message message;

  @override
  _ItemMessageReceiverState createState() => _ItemMessageReceiverState();
}

class _ItemMessageReceiverState extends State<ItemMessageReceiver> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xffEBEBEB);
    Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 5, left: 8),
              child: Text(widget.message.sender.name,
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
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 7,
                    child: Row(
                      children: [
                        Text(
                          getStringTime(widget.message.sentAt),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: kMainBlueColor,
                          size: 15,
                        )
                      ],
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
