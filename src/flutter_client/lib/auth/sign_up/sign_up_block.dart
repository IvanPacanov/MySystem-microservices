import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_cubit.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/auth/form_submission_status.dart';
import 'package:flutter_client/auth/sign_up/sign_up_event.dart';
import 'package:flutter_client/auth/sign_up/sign_up_state.dart';
import 'package:flutter_client/constants.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepo, required this.authCubit})
      : super(SignUpState());

  Stream<QuerySnapshot> get todos {
    print("elooo");

    var a = FirebaseFirestore.instance
        .collection(USER_COLLECTION)
        .doc('0sqzFChjC7rL1Iq7MtBz')
        .collection(FRIEND_COLLECIONT)
        .snapshots();
    return a;
  }

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

      // Form submitted
    } else if (event is SignUpSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.signUp(
          userName: state.username,
          email: state.email,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit.showConfirmSignUp(
          userName: state.username,
          email: state.email,
          password: state.password,
        );
      } catch (e) {
        yield state.copyWith(
            formStatus: SubmissionFailed(e as Exception));
      }
    }
  }
}