import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_credentials.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/session/session_cubit.dart';

enum AuthState { login_registration, login, confirmLogin, registration, confirmSignUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login_registration);

  AuthCredentials? credentials;

  void openLoginPage() => emit(AuthState.login);
  void openRegistrationPage() => emit(AuthState.registration);
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

  void launchSession(User credentials) =>
      sessionCubit.showSession(credentials);

  void showConfirmLogin(User user) {
    //emit(AuthState.confirmSignUp);
    // emit(AuthState.confirmLogin);
    sessionCubit.showSession(user);
  }
}
