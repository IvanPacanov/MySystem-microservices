import 'package:flutter/material.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/ChatMessage.dart';
import 'package:flutter_client/models/Message.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:text_to_speech/text_to_speech.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
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
    TextToSpeech tts = TextToSpeech();
    return Row(
      children: [
        if (message.userId == userId)
          Container(
            margin: EdgeInsets.only(top: defaulPadding),
            child: IconButton(
                onPressed: () {
                  tts.speak(message.text);
                },
                icon: Icon(Icons.campaign_sharp)),
          ),
        Container(
          margin: EdgeInsets.only(top: defaulPadding),
          padding: EdgeInsets.symmetric(
            horizontal: defaulPadding * 0.75,
            vertical: defaulPadding / 2,
          ),
          decoration: BoxDecoration(
              color: primaryColor
                  .withOpacity(message.userId == userId ? 1 : 0.1),
              borderRadius: BorderRadius.circular(30)),
          child: Text(
            message.text,
            style: TextStyle(
              color: message.userId == userId
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyText1!.color,
            ),
          ),
        ),
        if (message.userId != userId)
          Container(
            margin: EdgeInsets.only(top: defaulPadding),
            child: IconButton(
                onPressed: () {
                  tts.speak(message.text);
                },
                icon: Icon(Icons.campaign_sharp)),
          ),
      ],
    );
  }
}
