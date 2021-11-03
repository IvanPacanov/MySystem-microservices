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
import 'package:flutter_client/session/session_state.dart';

part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ComponentRepository componehtRepository;
  final AuthRepository authRepository;
  final SignalRProvider signalR = new SignalRProvider();

  ChatBloc(
      {required this.componehtRepository,
      required this.authRepository})
      : super(ChatState(users: [])) {
    signalR.initSignalR(authRepository.userCred);
  }

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatDownloadFirstData) {
      print("Cos");
    }
  }

  void sendCos() async {
    await signalR.sendMeMessage();
  }
}
