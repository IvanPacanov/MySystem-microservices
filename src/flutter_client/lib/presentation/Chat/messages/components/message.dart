import 'package:flutter/material.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/Message.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/Chat/messages/components/text_message.dart';

class MessageTextBodyScreen extends StatelessWidget {
  const MessageTextBodyScreen({
    Key? key,
    required this.message,
    required this.friend,
    required this.userId,
  }) : super(key: key);

  final UserFriend friend; 
  final Message message;
  final int userId;

  @override
  Widget build(BuildContext context) {
    Widget messageContains(Message message) {
      switch (message.messageType) {
        case MessageTypeNew.text:
          return TextMessage(message: message, userId: userId, friend: friend);
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Row(
        mainAxisAlignment: message.userId == userId
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          messageContains(message),
        ],
      ),
    );
  }
}
