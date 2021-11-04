abstract class ChatSessionState {}

class ComingCalling extends ChatSessionState {
  final String offer;
  final String uid;

  ComingCalling({required this.offer, required this.uid});
}

class NormalState extends ChatSessionState {}

class Authenticated extends ChatSessionState {
  final dynamic user;

  Authenticated({required this.user});
}
