import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';

part 'guardian_event.dart';
part 'guardian_state.dart';

class GuardianBloc extends Bloc<GuardianEvent, GuardianState> {
  late UserFriend? friend;
  final AuthenticatedSessionCubit authenticatedSessionCubit;

  GuardianBloc({required this.authenticatedSessionCubit})
      : super(GuardianInitial()) {}

  @override
  Stream<GuardianState> mapEventToState(GuardianEvent event) async* {
    if (event is ReminderEvent) {
      this
          .authenticatedSessionCubit
          .signalRProvider
          .sendReminder(event.message, event.targetConnectionId);
    } else if (event is CheckStatusEvent) {
      if (this.friend != null) {
        this
            .authenticatedSessionCubit
            .signalRProvider
            .checkStatus(this.friend!.connectionId as String);
      }
    }
  }
}
