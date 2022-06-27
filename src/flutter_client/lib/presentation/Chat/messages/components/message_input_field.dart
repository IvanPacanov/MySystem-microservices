import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/Chat/messages/bloc/message_bloc.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/chatSession_cubit.dart';

class MessageInputField extends StatelessWidget {
  const MessageInputField(
      {Key? key, required this.friend, required this.chatId})
      : super(key: key);

  final int chatId;
  final UserFriend friend;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignalRProvider(
          chatSessionCubit:
              context.read<AuthenticatedSessionCubit>()),
      child: BlocProvider(
        create: (context) => MessageBloc(
            signalR: context.read<SignalRProvider>(),
            authRepository: context.read<AuthRepository>()),
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
                                      suffixIcon: IconButton(
                                          icon: Icon(Icons.send),
                                          onPressed: () => context
                                              .read<MessageBloc>()
                                              .add(MessageSend(
                                                  friend, chatId)))),
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
      ),
    );
  }
}
