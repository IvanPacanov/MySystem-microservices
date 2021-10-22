import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_credentials.dart';
import 'package:flutter_client/auth/auth_cubit.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/auth/form_submission_status.dart';
import 'package:flutter_client/auth/login/login_event.dart';
import 'package:flutter_client/auth/login/login_state.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/repositories/firebase_api.dart';
import 'package:flutter_client/utils.dart';

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
        final user = await authRepository.loginWithEmailAndPassword(
          email: "mat@gmail.com",
          password: "123456789",
        );
        yield state.copyWith(formStatus: SubmissionSuccess());
       
       
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc('0sqzFChjC7rL1Iq7MtBz')
            .get();
        var a =
            User.fromJson(snapshot.data() as Map<String, dynamic>);

        var querySnapshot2 = await FirebaseFirestore.instance
            .collection('users')
            .doc('0sqzFChjC7rL1Iq7MtBz')
            .collection('friends')
            .get();

 

        authCubit.showConfirmLogin(user);
      } catch (e) {
        print(e.toString());
        yield state.copyWith(
            formStatus: SubmissionFailed(e as Exception));
      }
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final user = await authRepository.loginWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());
        authCubit.showConfirmLogin(user);
      } catch (e) {
        yield state.copyWith(
            formStatus: SubmissionFailed(e as Exception));
      }
    }
  }
}
