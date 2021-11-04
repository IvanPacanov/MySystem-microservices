import 'package:flutter/material.dart';
import 'package:flutter_client/components/chat/messages/components/text_message.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/ChatMessage.dart';

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.chatMessage,
  }) : super(key: key);

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    Widget messageContaint(ChatMessage message) {
      switch (message.messageType) {
        case MessageType.text:
          return TextMessage(message: message);
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: defaulPadding),
      child: Row(
        // mainAxisAlignment: chatMessage.isSender
        //     ? MainAxisAlignment.end
        //     : MainAxisAlignment.start,
        children: [
          //   if (!chatMessage.isSender) ...[
          //     CircleAvatar(
          //       radius: 12,
          //       backgroundImage: AssetImage("assets/images/dog.png"),
          //     ),
          //     SizedBox(width: defaulPadding / 2),
          //   ],
          messageContaint(chatMessage),
        ],
      ),
    );
  }
}
