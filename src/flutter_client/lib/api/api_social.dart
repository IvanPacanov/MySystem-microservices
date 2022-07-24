import 'dart:convert';

import 'package:flutter_client/environments/environments.dart';
import 'package:flutter_client/models/User.dart';
import 'package:http/http.dart' as http;

class ApiSocial {
  Future<User> getProfileData({required String email}) async {
    var response = await http.get(
        Uri.parse(API_SOCIAL_PROFILE_URL + "get-profile-info/$email"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 200) {
      print(response.body);
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

  addFriend({required String email, required int userId}) async {
    var response = await http.post(
      Uri.parse(API_SOCIAL_PROFILE_URL + "add-friend"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
        'emailFriend': email,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<bool> actionInvitationFriend(
      {required int userId,
      required int friendId,
      required String flag}) async {
    var response = await http.post(
      Uri.parse(API_SOCIAL_PROFILE_URL +
          "action-invitation-friend?id=$userId&whoSend=$friendId&friend=$flag"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> cancelInvitation(
      {required int userId, required int friendId}) async {
    var response = await http.post(
      Uri.parse(API_SOCIAL_PROFILE_URL +
          "cancel-invitation-friend?id=$userId&whoSend=$friendId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
