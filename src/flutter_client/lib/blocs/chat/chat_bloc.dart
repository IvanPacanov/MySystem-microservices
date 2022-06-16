import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/blocs/chat/chat_state.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/repositories/component_repository.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/chatSession_cubit.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ComponentRepository componehtRepository;
  final AuthRepository authRepository;
  final ChatSessionCubit chatSessionCubit;
  final SignalRProvider signalR;

  ChatBloc(
      {required this.componehtRepository,
      required this.authRepository,
      required this.signalR,
      required this.chatSessionCubit})
      : super(ChatState(users: [])) {
    signalR.initSignalR(authRepository.userNew);
    signalR.onFriendsUpdateCallback =
        (data) => updateFriendsConnectionID(data);

    signalR.onFriendUpdateCallback =
        (data) => updateFriendConnectionID(data);
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
    var user = authRepository.userNew.friends
        .where((z) => z.email == testItem['email'])
        .first;

    int index = authRepository.userNew.friends.indexOf(user);
    authRepository.userNew.friends[index].connectionId =
        testItem['ConnectionId'];
  }

  void sendCos() async {
    await signalR.sendMeMessage();
  }
}
