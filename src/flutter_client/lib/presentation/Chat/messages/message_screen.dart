import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/blocs/chat/chat_bloc.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/VideoCall.dart';
import 'package:flutter_client/presentation/VideoCalling/Calling.dart';
import 'package:flutter_client/presentation/VideoCalling/VideoCall2.dart';
import 'package:flutter_client/services/SignalR_Services.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/src/provider.dart';

import 'components/body.dart';

class MessageScreen extends StatefulWidget {
  // final BuildContext context;
  final UserFriend friend;
  const MessageScreen({Key? key, required this.friend})
      : super(key: key);

  @override
  _MessageScreen createState() => _MessageScreen(friend: friend);
}

class _MessageScreen extends State<MessageScreen> {
  final UserFriend friend;
  _MessageScreen({required this.friend});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: buildAppBar(context),
      body: BodyMessageScreen(context,
          chats: friend.chats![0], friend: friend),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(
            onPressed: () {
              context.read<AuthenticatedSessionCubit>().lastState();
            },
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(friend.urlAvatar!),
          ),
          SizedBox(width: defaulPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                friend.nick!,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.local_phone),
        ),
        IconButton(
          onPressed: () {
            context
                .read<AuthenticatedSessionCubit>()
                .goToVideoCall(friend);
          },
          icon: Icon(Icons.videocam),
        ),
        SizedBox(
          width: defaulPadding / 2,
        )
      ],
    );
  }
}
