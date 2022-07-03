import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/blocs/chat/chat_state.dart';
import 'package:flutter_client/models/Message.dart';
import 'package:flutter_client/models/MessageSignalR.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/repositories/component_repository.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/chatSession_cubit.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final AuthServices authRepository = new AuthServices();
  final AuthenticatedSessionCubit chatSessionCubit;

  ChatBloc(
      {required this.chatSessionCubit})
      : super(ChatState(users: [])) {
    chatSessionCubit.signalRProvider.onSendOwnMessageCallback =
        (data) => test(data);
    chatSessionCubit.signalRProvider.onFriendsUpdateCallback =
        (data) => updateFriendsConnectionID(data);

    chatSessionCubit.signalRProvider.onFriendUpdateCallback =
        (data) => updateFriendConnectionID(data);

    chatSessionCubit.signalRProvider.onReceivedMessageCallback =
        (data) => receivedMessage(data);
  }

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatDownloadFirstData) {
      print("Cos");
    }
  }

  void updateFriendsConnectionID(List<dynamic>? data) {
    List<dynamic> test = jsonDecode(data![0]);
    test.forEach((dynamic testItem) => {_testElo(testItem)});
  }

  void updateFriendConnectionID(dynamic? data) {
    dynamic test = jsonDecode(data);
    _testElo(test);
  }

  void _testElo(dynamic testItem) {
    var user = authRepository.user.friends
        .where((z) => z.email == testItem['email'])
        .first;

    int index = authRepository.user.friends.indexOf(user);
    authRepository.user.friends[index].connectionId =
        testItem['ConnectionId'];
  }

  void sendCos() async {
    await chatSessionCubit.signalRProvider.sendMeMessage();
  }

  receivedMessage(MessageSignalR data) {
    var user = authRepository.user.friends
        .where((z) => z.id == data.userId)
        .first;

    int index = authRepository.user.friends.indexOf(user);

    Message message = new Message(
        userId: data.userId,
        text: data.text,
        read: data.read,
        send: data.send);

    authRepository.user.friends[index].chats![0].messages!
        .add(message);
  }

  test(bool value) {
    print(value);
  }
}
