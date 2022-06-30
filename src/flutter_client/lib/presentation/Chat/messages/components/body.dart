import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/blocs/chat/chat_bloc.dart';
import 'package:flutter_client/blocs/chat/chat_state.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/ChatMessage.dart';
import 'package:flutter_client/models/NewChat.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/Chat/messages/components/message.dart';
import 'package:flutter_client/presentation/Chat/messages/components/message_input_field.dart';
import 'package:flutter_client/repositories/component_repository.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/chatSession_cubit.dart';
import 'package:flutter_client/session/session_cubit.dart';
import 'package:flutter_client/session/session_state.dart';

class Body extends StatefulWidget {
  final NewChat chats;
  final UserFriend friend;
  Body({required this.chats, required this.friend});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignalRProvider(
            chatSessionCubit:
                context.read<AuthenticatedSessionCubit>()),
        child: BlocProvider(
          create: (context) => ChatBloc(
              authRepository: context.read<AuthRepository>(),
              chatSessionCubit:
                  context.read<AuthenticatedSessionCubit>(),
              signalR: context.read<SignalRProvider>()),
          child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
            return TestColumn(context);
          }),
        ));
  }

  Widget TestColumn(BuildContext context) {
    context.read<ChatBloc>().signalR.onReceivedMessageCallback =
        (data) => {setState(() {})};

    context.read<ChatBloc>().signalR.onSendOwnMessageCallback =
        (data) => {
          setState(() {})};
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
                    userId:
                        context.read<AuthRepository>().userNew.id!);
              },
            ),
          ),
        ),
        MessageInputField(
            friend: widget.friend, chatId: widget.chats.id!)
      ],
    );
  }
}
