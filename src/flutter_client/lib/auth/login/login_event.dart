

abstract class LoginEvent {}

class LoginUsernameChanged extends LoginEvent {
  final String userName;

  LoginUsernameChanged({required this.userName});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged({required this.password});
}

class LoginAsGuest extends LoginEvent {
  
}

class LoginSubmitted extends LoginEvent{}

