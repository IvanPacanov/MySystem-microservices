import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_credentials.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/session/session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;

  SessionCubit({required this.authRepo})
      : super(UnKnownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final userId = await authRepo.attemptAutoLogin();
      //final user = dataRepo.getUser(userId);
      final user = userId;
      emit(Authenticated(user: user));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());
  void showSession(UserCredential credentials) {
    // final user = dataRepo.getUser(credentials.userId);
    final user = credentials;
    print(user);
    emit(Authenticated(user: user));
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
