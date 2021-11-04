import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_credentials.dart';
import 'package:flutter_client/session/session_cubit.dart';

enum AuthState { login, confirmLogin, signUp, confirmSignUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  AuthCredentials? credentials;

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);
  void showConfirmSignUp({
    required String userName,
    required String email,
    required String password,
  }) {
    credentials = AuthCredentials(
      userName: userName,
      email: email,
      password: password,
    );
    emit(AuthState.login);
  }

  void launchSession(UserCredential credentials) =>
      sessionCubit.showSession(credentials);

  void showConfirmLogin(UserCredential user) {
    //emit(AuthState.confirmSignUp);
    // emit(AuthState.confirmLogin);
    sessionCubit.showSession(user);
  }
}
