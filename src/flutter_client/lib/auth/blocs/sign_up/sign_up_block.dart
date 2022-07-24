import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_cubit.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/auth/form_submission_status.dart';
import 'package:flutter_client/auth/blocs/sign_up/sign_up_event.dart';
import 'package:flutter_client/auth/blocs/sign_up/sign_up_state.dart';
import 'package:flutter_client/constants.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthServices authRepository;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepository, required this.authCubit})
      : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    // Username updated
    if (event is SignUpUsernameChanged) {
      yield state.copyWith(username: event.username);

      // Email updated
    } else if (event is SignUpEmailChanged) {
      yield state.copyWith(email: event.email);

      // Password updated
    } else if (event is SignUpPasswordChanged) {
      yield state.copyWith(password: event.password);
    } else if (event is SignUpPhoneChanged) {
      yield state.copyWith(phoneNumber: event.phone);
    } else if (event is SignUpLastNameChanged) {
      yield state.copyWith(lastName: event.lastName);
    } else if (event is SignUpFirstNameChanged) {
      yield state.copyWith(firstName: event.firstName);

      // Form submitted
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final results = await authRepository.registerUser(
            email: state.email,
            password: state.password,
            userName: state.username,
            firstName: state.firstName,
            lastName: state.lastName,
            phone: state.phoneNumber);
        yield state.copyWith(formStatus: SubmissionSuccess());

        if (results) {
          final user = await authRepository.loginWithEmailAndPassword(
            userName: state.username,
            password: state.password,
          );
          authCubit.showConfirmLogin(user);
        } else {
          authCubit.showConfirmSignUp(
              email: state.email,
              password: state.password,
              userName: state.username,
              firstName: state.firstName,
              lastName: state.lastName,
              phoneNumber: state.phoneNumber);
        }
      } catch (e) {
        yield state.copyWith(
            formStatus: SubmissionFailed(e as Exception));
      }
    }
  }
}
