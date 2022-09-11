import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/blocs/chat/chat_bloc.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/Chat/messages/bloc/message_bloc.dart';
import 'package:flutter_client/services/SignalR_Services.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'package:provider/provider.dart';
import 'package:text_to_speech/text_to_speech.dart';

class MessageInputField extends StatelessWidget {
  const MessageInputField(BuildContext context,
      {Key? key, required this.friend, required this.chatId})
      : super(key: key);

  final int chatId;
  final UserFriend friend;

  @override
  Widget build(BuildContext context) {
    TextToSpeech tts = TextToSpeech();
    return BlocProvider(
      create: (context) => MessageBloc(
          signalR:
              Provider.of<SignalRProvider>(context, listen: false),
          authRepository:
              Provider.of<AuthServices>(context, listen: false)),
      child: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: defaulPadding,
              vertical: defaulPadding / 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 32,
                  color: Color(0x0FF087949).withOpacity(0.08),
                ),
              ],
            ),
            child: SafeArea(
                child: Row(
              children: [
                // Icon(Icons.mic, color: primaryColor),
                // SizedBox(width: defaulPadding),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaulPadding * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                                decoration: InputDecoration(
                                    hintText: "Wprowadź wiadomość",
                                    border: InputBorder.none,
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        IconButton(
                                            onPressed: () {
                                              tts.speak(
                                                  state.message);
                                            },
                                            icon: Icon(Icons
                                                .campaign_sharp)),
                                        IconButton(
                                            icon: Icon(Icons.send),
                                            onPressed: () => context
                                                .read<MessageBloc>()
                                                .add(MessageSend(
                                                    friend, chatId))),
                                      ],
                                    )),
                                onChanged: (value) => context
                                    .read<MessageBloc>()
                                    .add(MessageChanged(
                                        message: value))))
                      ],
                    ),
                  ),
                )
              ],
            )),
          );
        },
      ),
    );
  }
}
