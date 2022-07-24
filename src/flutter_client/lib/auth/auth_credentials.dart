class AuthCredentials {
  final String? email;
  final String? password;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  String? userId;

  AuthCredentials(
      {this.userName,
      this.email,
      this.password,
      this.userId,
      this.firstName,
      this.lastName,
      this.phoneNumber});
}
