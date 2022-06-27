abstract class AuthenticatedSessionState {}

class ComingCalling extends AuthenticatedSessionState {
  final String offer;
  final String uid;

  ComingCalling({required this.offer, required this.uid});
}

class NormalState extends AuthenticatedSessionState {}

class Authenticated extends AuthenticatedSessionState {
  final dynamic user;

  Authenticated({required this.user});
}
