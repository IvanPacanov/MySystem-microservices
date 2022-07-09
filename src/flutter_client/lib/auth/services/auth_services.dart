import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/api/api_auth.dart';
import 'package:flutter_client/api/api_social.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthServices extends Bloc {
  final storage = new FlutterSecureStorage();

  final ApiAuth _apiAuth = new ApiAuth();
  final ApiSocial _apiSocial = new ApiSocial();

  late User user;
  late String token;

  AuthServices() : super(AuthServices);

  void setToken(String token) {
    this.token = token;
  }

  // AuthCredentials _userFromFirebaseUser(User? user) {
  //   return AuthCredentials(userId: user!.uid);
  // }

  // Future<String> attemptAutoLogin() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   throw Exception('not signed in');
  // }

  Future<User> loginWithEmailAndPassword({
    required String userName,
    required String password,
  }) async {
    print('attempting login');
    var test =
        await _apiAuth.login(userName: userName, password: password);

    this.user = await _apiSocial.getProfileData(email: test['email']);

    storeTokenAndData(user, 'token');

    return this.user;
  }

  Future<User> getProfile({
    required String email,
  }) async {
    return this.user = await _apiSocial.getProfileData(email: email);
  }
  // Future signUp({
  //   required String email,
  //   required String userName,
  //   required String password,
  // }) async {
  //   try {
  //     UserCredential result =
  //         await _auth.createUserWithEmailAndPassword(
  //             email: email, password: password);
  //     User user = result.user!;
  //     FireBaseApi.newUserAfterRegister(user.uid, userName);
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // Future<String> confirmSignUp({
  //   required String userName,
  //   required String confirmationCode,
  // }) async {
  //   try {
  //     UserCredential result =
  //         await Future.delayed(Duration(seconds: 2));
  //     return 'OK';
  //   } catch (e) {
  //     print(e.toString());
  //     return "Error during registration - $e";
  //   }
  // }

  // Future<void> signOut() async {
  //   try {
  //     await _auth.signOut();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Future<void> storeTokenAndData(User user, String token) async {
    await storage.write(key: 'token', value: token);
    await storage.write(
        key: 'userEmail', value: user.email.toString());
  }

  Future<String?> getUserId() async {
    return await storage.read(key: 'userEmail');
  }

  Future<void> logout() async {
    await storage.delete(key: 'userEmail');
  }
}
