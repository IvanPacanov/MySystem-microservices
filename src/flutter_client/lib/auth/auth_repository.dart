import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_client/auth/auth_credentials.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthCredentials _userFromFirebaseUser(User? user) {
    return AuthCredentials(userId: user!.uid);
  }

  StreamSubscription<User?> get user {
    return _auth.authStateChanges().listen(_userFromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> attemptAutoLogin() async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception('not signed in');
  }

  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    print('attempting login');
    var user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return user;
  }

  Future signUp({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> confirmSignUp({
    required String userName,
    required String confirmationCode,
  }) async {
    try {
      UserCredential result =
          await Future.delayed(Duration(seconds: 2));
      return 'OK';
    } catch (e) {
      print(e.toString());
      return "Error during registration - $e";
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
