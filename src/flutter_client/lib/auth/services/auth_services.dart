import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/api/api_auth.dart';
import 'package:flutter_client/api/api_social.dart';
import 'package:flutter_client/models/MessageSignalR.dart';
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

  Future<bool> registerUser({
    required String email,
    required String userName,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    print('register User');
    return await _apiAuth.register(
        email: email,
        userName: userName,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone);
  }

  Future<User> getProfile({
    required String email,
  }) async {
    return this.user = await _apiSocial.getProfileData(email: email);
  }

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

  Future<User> addNewFriend(String email) async {
    return this.user =
        await _apiSocial.addFriend(email: email, userId: user.id!);
  }

  Future<bool> actionFriendFlag(
      int userId, int friendId, String flag) async {
    return await _apiSocial.actionInvitationFriend(
        userId: userId, friendId: friendId, flag: flag);
  }

  Future<bool> cancelInvitation(int userId, int friendId) async {
    return await _apiSocial.cancelInvitation(
        userId: userId, friendId: friendId);
  }

//   void sendMessage(MessageSignalR message, int userId) async {
//     await _apiSocial.sendMessage(
//         message: message, userId: userId);
// }
}
