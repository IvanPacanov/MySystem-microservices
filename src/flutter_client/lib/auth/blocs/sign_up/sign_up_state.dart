import 'package:flutter_client/auth/form_submission_status.dart';

class SignUpState {
  final String email;
  bool get isValidEmail => email.contains('@');

  final String password;
  bool get isValidPassword => password.length > 6;

  final String username;
  bool get isValidUsername => username.length > 3;

  final String firstName;
  final String lastName;
  final String phoneNumber;
  bool get isValidPhoneNumber => phoneNumber.length >= 9;

  final FormSubmissionStatus formStatus;

  SignUpState({
    this.firstName ='',
    this.lastName = '',
    this.phoneNumber = '', 
    this.email = '',
    this.password = '',
    this.username = '',
    this.formStatus = const InitialFormStatus(),
  });

  SignUpState copyWith({
    String? username,
    String? email,
    String? password,
    String? lastName,
    String? firstName,
    String? phoneNumber,
    FormSubmissionStatus? formStatus,
  }) {
    return SignUpState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      lastName: lastName ?? this.lastName,
      firstName: firstName ?? this.firstName,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
