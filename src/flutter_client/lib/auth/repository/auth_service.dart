import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/api/api_auth.dart';
import 'package:flutter_client/api/api_social.dart';
import 'package:flutter_client/auth/auth_credentials.dart';
import 'package:flutter_client/models/User.dart' as UserAuth;
import 'package:flutter_client/repositories/firebase_api.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';

class AuthRepository extends Bloc {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final ApiAuth _apiAuth = new ApiAuth();
  final ApiSocial _apiSocial = new ApiSocial();
  // late UserCredential userCred;
  late UserAuth.User userNew;

  late String token;

  AuthRepository() : super(AuthRepository);

  // void setUser(UserCredential user) {
  //   this.userCred = user;
  // }

  void setToken(String token) {
    this.token = token;
  }

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

  Future<UserAuth.User> loginWithEmailAndPassword({
    required String userName,
    required String password,
  }) async {
    print('attempting login');
    var test =
        await _apiAuth.login(userName: userName, password: password);

    this.userNew =
        await _apiSocial.getProfileData(email: test['email']);
    return this.userNew;
  }

  Future signUp({
    required String email,
    required String userName,
    required String password,
  }) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
      User user = result.user!;
      // FireBaseApi.newUserAfterRegister(user.uid, userName);
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
