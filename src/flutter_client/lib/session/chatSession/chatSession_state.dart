import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/models/UserFriend.dart';

abstract class AuthenticatedSessionState {}

class ComingCalling extends AuthenticatedSessionState {
  final String offer;
  final String uid;

  ComingCalling({required this.offer, required this.uid});
}

class InComingCalling extends AuthenticatedSessionState {
  final UserFriend callingUser;
  final String offer;
  final String uid;

  InComingCalling(
      {required this.callingUser,
      required this.offer,
      required this.uid});
}

class NormalState extends AuthenticatedSessionState {}

class ChatViewState extends AuthenticatedSessionState {}

class GuardianViewState extends AuthenticatedSessionState {
  final User user;

  GuardianViewState({required this.user});
}

class FriendViewState extends AuthenticatedSessionState {}

class TextToSpeechState extends AuthenticatedSessionState {}

class VideoCallState extends AuthenticatedSessionState {
  final UserFriend friend;

  VideoCallState({required this.friend});
}

class ReceivedUpcomingVideoState extends AuthenticatedSessionState {
  final String offer;
  final String uid;

  ReceivedUpcomingVideoState(
      {required this.offer, required this.uid});
}

class MessageViewState extends AuthenticatedSessionState {
  final UserFriend friend;

  MessageViewState({required this.friend});
}

class Authenticated extends AuthenticatedSessionState {
  final dynamic user;

  Authenticated({required this.user});
}
