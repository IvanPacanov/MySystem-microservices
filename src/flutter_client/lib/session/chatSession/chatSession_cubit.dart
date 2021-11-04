import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/session/chatSession/chatSession_state.dart';

class ChatSessionCubit extends Cubit<ChatSessionState> {
  ChatSessionCubit() : super(NormalState());

  void comingCalling(String offer, String uid) {
    emit(ComingCalling(offer: offer, uid: uid));
  }
}
