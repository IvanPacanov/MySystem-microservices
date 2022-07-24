import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/blocs/addNewUser/addnewuser_event.dart';
import 'package:flutter_client/blocs/addNewUser/addnewuser_state.dart';
import 'package:flutter_client/repositories/component_repository.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';

class AddNewUserBloc extends Bloc<AddNewUserEvent, AddNewUserState> {
  bool isTrusted = false;
  final AuthServices authRepository;
  final AuthenticatedSessionCubit authenticatedSessionCubit;

  AddNewUserBloc(
      {required this.authRepository,
      required this.authenticatedSessionCubit})
      : super(AddNewUserState());

  @override
  Stream<AddNewUserState> mapEventToState(
      AddNewUserEvent event) async* {
    if (event is UserNameChanged) {
      yield state.copyWith(userName: event.userName);
    } else if (event is AddNewFriendSubmitted) {
      var result = await authRepository.addNewFriend(state.userName);
      if (result != null) {
        authenticatedSessionCubit.user = result;
        authenticatedSessionCubit.lastState();
      }
    }
  }
}
