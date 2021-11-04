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
