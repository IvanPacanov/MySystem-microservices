import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_cubit.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/auth/blocs/confirm/confirmation_event.dart';
import 'package:flutter_client/auth/blocs/confirm/confirmation_state.dart';
import 'package:flutter_client/auth/form_submission_status.dart';

class ConfirmationBloc
    extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(ConfirmationState());

//tutaj obsługujemy eventy

  @override
  Stream<ConfirmationState> mapEventToState(
      ConfirmationEvent event) async* {
    // Confirmation code updated
    if (event is ConfirmationCodeChanged) {
      yield state.copyWith(code: event.code);

      // Form submitted
    } else if (event is ConfirmationSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        await authRepo.confirmSignUp(
          userName: authCubit.credentials!.email!,
          confirmationCode: state.code,
        );

        yield state.copyWith(formStatus: SubmissionSuccess());

        final credentials = authCubit.credentials;
        final user = await authRepo.loginWithEmailAndPassword(
            email: credentials!.userName!,
            password: credentials.password!);
        authCubit.launchSession(user);
      } catch (e) {
        print(e);
        yield state.copyWith(
            formStatus: SubmissionFailed(e as Exception));
      }
    }
  }
}
