import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_cubit.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/auth/form_submission_status.dart';
import 'package:flutter_client/auth/blocs/login/login_event.dart';
import 'package:flutter_client/auth/blocs/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepository, required this.authCubit})
      : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    //oczekiwanie na event --> Loading

    //metoda do wygenerowania danych

    //Może delay

    //Stan loaded + przekazanie wartości

    if (event is LoginUsernameChanged) {
      yield state.copyWith(email: event.userName);
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is LoginAsGuest) {
      try {
        // dynamic user = await authRepository.signInAnon();
        final token = await authRepository.loginWithEmailAndPassword(
          userName: "Admin",
          password: "Admin",
        );
        print("TODO AUTORYZACJA Z POBIERANIEM!!!!");
        // authRepository.setToken(token);
        yield state.copyWith(formStatus: SubmissionSuccess());
        // authCubit.showConfirmLogin(user);
      } catch (e) {
        print(e.toString());
        yield state.copyWith(
            formStatus: SubmissionFailed(e as Exception));
      }
    } else if (event is LoginAsGuest2) {
      try {
        // dynamic user = await authRepository.signInAnon();
        final user = await authRepository.loginWithEmailAndPassword(
          userName: "dreezy",
          password: "dreezy",
        );
        // authRepository.setToken(user);
        yield state.copyWith(formStatus: SubmissionSuccess());
        // authCubit.showConfirmLogin(user);
      } catch (e) {
        print(e.toString());
        yield state.copyWith(
            formStatus: SubmissionFailed(e as Exception));
      }
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final user = await authRepository.loginWithEmailAndPassword(
          userName: state.email,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());
        authCubit.showConfirmLogin(user);

        // authRepository.setToken(token);
      } catch (e) {
        yield state.copyWith(
            formStatus: SubmissionFailed(e as Exception));
      }
    }
  }
}
