import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/blocs/chat/chat_bloc.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/ChatMessage.dart';
import 'package:flutter_client/models/NewChat.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/Chat/messages/components/message.dart';
import 'package:flutter_client/presentation/Chat/messages/components/message_input_field.dart';
import 'package:flutter_client/session/session_cubit.dart';

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
   final ChatBloc todoBloc = context.read<ChatBloc>();
  todoBloc.on(MessageIsComming(),);

    return BlocProvider(
      create: (context) =>
          SessionCubit(authRepo: context.read<AuthRepository>()),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: defaulPadding),
              child: ListView.builder(
                itemCount: widget.chats.messages!.length,
                itemBuilder: (context, index) => MessageScreen(
                    message: widget.chats.messages![index],
                    friend: widget.friend,
                    userId:
                        context.read<AuthRepository>().userNew.id!),
              ),
            ),
          ),
          MessageInputField(friend: widget.friend, chatId: widget.chats.id!)
        ],
      ),
    );
  }
}
