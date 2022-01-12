import 'package:flutter/material.dart';

class ItemMessageNotify extends StatelessWidget {
  const ItemMessageNotify({Key? key, required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(message),
      ),
    );
  }
}
