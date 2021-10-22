import 'package:flutter/material.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/ChatMessage.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(top: defaulPadding),
        // padding: EdgeInsets.symmetric(
        //   horizontal: defaulPadding * 0.75,
        //   vertical: defaulPadding / 2,
        // ),
        // decoration: BoxDecoration(
        //     color: primaryColor.withOpacity(message.isSender ? 1 : 0.1),
        //     borderRadius: BorderRadius.circular(30)),
        // child: Text(
        //   message.text,
        //   style: TextStyle(
        //     color: message.isSender
        //         ? Colors.white
        //         : Theme.of(context).textTheme.bodyText1!.color,
        //   ),
        // ),
        );
  }
}
