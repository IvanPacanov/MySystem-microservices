import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/blocs/chat/chat_bloc.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/NewChat.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/Chat/messages/components/message.dart';
import 'package:flutter_client/presentation/Chat/messages/components/message_input_field.dart';
import 'package:flutter_client/session/chatSession/chatSession_cubit.dart';
import 'package:provider/provider.dart';

class BodyMessageScreen extends StatefulWidget {
  final NewChat chats;
  final UserFriend friend;
  BodyMessageScreen(BuildContext context,
      {required this.chats, required this.friend});

  @override
  State<BodyMessageScreen> createState() => _BodyState();
}

class _BodyState extends State<BodyMessageScreen> {
  @override
  Widget build(BuildContext context) {
    var z = context.read<ChatBloc>().authRepository.user;
    return BlocProvider(
        create: (context) => ChatBloc(
              authRepository: context.read<AuthServices>(),
              chatSessionCubit:
                  context.read<AuthenticatedSessionCubit>(),
            ),
        child: TestColumn(context));
  }

  Widget TestColumn(BuildContext context) {
    context
        .read<ChatBloc>()
        .chatSessionCubit
        .signalRProvider
        .onReceivedMessageCallback = (data) => {setState(() {})};

    context
        .read<ChatBloc>()
        .chatSessionCubit
        .signalRProvider
        .onSendOwnMessageCallback = (data) => {setState(() {})};
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: defaulPadding),
            child: ListView.builder(
              reverse: true,
              itemCount: widget.chats.messages!.length,
              itemBuilder: (context, index) {
                final reversedIndex =
                    widget.chats.messages!.length - 1 - index;
                final item = widget.chats.messages![reversedIndex];
                return MessageScreen(
                    message: item,
                    friend: widget.friend,
                    userId: context
                        .read<ChatBloc>()
                        .chatSessionCubit
                        .user
                        .id!);
              },
            ),
          ),
        ),
        MessageInputField(context,
            friend: widget.friend, chatId: widget.chats.id!)
      ],
    );
  }
}
