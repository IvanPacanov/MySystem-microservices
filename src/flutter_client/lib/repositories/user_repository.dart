import 'package:flutter_client/services/UserServis.dart';

class UserRepository {
  final UserServis _userServis;

  UserRepository(this._userServis);

  Future<void> signIn(String email, String password) {
    return _userServis.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp(String email, String password) {
    return _userServis.signUpWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut(String email, String password) {
    return Future.wait((_userServis.signOut()));
  }
}
