import 'package:flutter/material.dart';
import 'package:we_chat/componants/constant.dart';
import 'package:we_chat/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
                topRight: Radius.circular(32)),
            color: kPrimaryColor),
        child: Text(message.message,
            style: const TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}
