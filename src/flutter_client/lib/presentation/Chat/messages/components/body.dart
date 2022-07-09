import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/repository/auth_service.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/blocs/chat/chat_bloc.dart';
import 'package:flutter_client/blocs/chat/chat_state.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/NewChat.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/Chat/messages/components/message.dart';
import 'package:flutter_client/presentation/Chat/messages/components/message_input_field.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
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
    return TestColumn(context);
  }

  Widget TestColumn(BuildContext context) {
    final authRepository = Provider.of<AuthServices>(context);
    context
        .read<AuthenticatedSessionCubit>()
        .onFriendsUpdatedCallback = () => {setState(() {})};

     context
        .read<SignalRProvider>()
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
                return MessageTextBodyScreen(
                    message: item,
                    friend: widget.friend,
                    userId: authRepository.user.id!);
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
