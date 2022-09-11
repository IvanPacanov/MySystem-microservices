part of 'guardian_bloc.dart';

abstract class GuardianEvent extends Equatable {
  const GuardianEvent();

  @override
  List<Object> get props => [];
}

class ReminderEvent extends GuardianEvent {
  final String message;
  final String targetConnectionId;
  ReminderEvent(
      {required this.message, required this.targetConnectionId});
}

class CheckStatusEvent extends GuardianEvent {}
