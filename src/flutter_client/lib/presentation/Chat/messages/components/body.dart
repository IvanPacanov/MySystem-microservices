import 'package:flutter/material.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/ChatMessage.dart';
import 'package:flutter_client/presentation/Chat/messages/components/message.dart';
import 'package:flutter_client/presentation/Chat/messages/components/message_input_field.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: defaulPadding),
            child: ListView.builder(
              itemCount: mockChatMesage.length,
              itemBuilder: (context, index) => Message(
                chatMessage: mockChatMesage[index],
              ),
            ),
          ),
        ),
        MessageInputField()
      ],
    );
  }
}


