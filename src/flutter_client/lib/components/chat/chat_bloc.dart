import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/components/chat/chat_state.dart';
import 'package:flutter_client/components/component_cubit.dart';
import 'package:flutter_client/components/component_repository.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/repositories/firebase_api.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/chatSession_cubit.dart';
import 'package:flutter_client/session/session_state.dart';

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
  }

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatDownloadFirstData) {
      print("Cos");
    }
  }

  void updateFriendsConnectionID(List<dynamic>? data) {
    var z = jsonDecode(data![0]);
    print(z![0]['ConnectionId']);
  }

  void sendCos() async {
    await signalR.sendMeMessage();
  }
}
