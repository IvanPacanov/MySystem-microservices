abstract class SignUpEvent {}

class SignUpUsernameChanged extends SignUpEvent {
  final String username;

  SignUpUsernameChanged({required this.username});
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged({required this.email});
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged({required this.password});
}
class SignUpFirstNameChanged extends SignUpEvent {
  final String firstName;

  SignUpFirstNameChanged({required this.firstName});
}

class SignUpLastNameChanged extends SignUpEvent {
  final String lastName;

  SignUpLastNameChanged({required this.lastName});
}
class SignUpPhoneChanged extends SignUpEvent {
  final String phone;

  SignUpPhoneChanged({required this.phone});
}

class SignUpSubmitted extends SignUpEvent {}