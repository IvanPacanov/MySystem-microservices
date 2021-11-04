import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/components/component_repository.dart';

enum ComponnetState { main, chat, signUp, confirmSignUp }

class ComponentCubit extends Cubit<ComponnetState> {
  //final SessionCubit sessionCubit;

  final ComponentRepository componentRepo;
  //ComponentCubit({required this.sessionCubit}) : super(ComponnetState.main);
ComponentCubit({required this.componentRepo}) : super(ComponnetState.main);

  // Główny user --> AuthCredentials? credentials;

  // void showLogin() => emit(AuthState.login);
  // void showSignUp() => emit(AuthState.signUp);
  // void showConfirmSignUp({
  //   required String userName,
  //   required String email,
  //   required String password,
  // }) {
  //   credentials = AuthCredentials(
  //     userName: userName,
  //     email: email,
  //     password: password,
  //   );
  //   emit(AuthState.confirmSignUp);
  // }

  // void launchSession(UserCredential credentials) =>
  //     sessionCubit.showSession(credentials);

  // void showConfirmLogin(UserCredential user) {
  //   //emit(AuthState.confirmSignUp);
  //   // emit(AuthState.confirmLogin);
  //   sessionCubit.showSession(user);
  // }
}