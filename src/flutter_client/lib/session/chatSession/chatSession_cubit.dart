import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/session/chatSession/chatSession_state.dart';


class AuthenticatedSessionCubit extends Cubit<AuthenticatedSessionState> {
  AuthenticatedSessionCubit() : super(NormalState());

  void comingCalling(String offer, String uid) {
    emit(ComingCalling(offer: offer, uid: uid));
  }

}
