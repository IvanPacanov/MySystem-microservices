import 'dart:convert';

import 'package:flutter_client/enviroments/enviroments.dart';
import 'package:flutter_client/models/User.dart';
import 'package:http/http.dart' as http;

class ApiSocial {
  Future<User> getProfileData({required String email}) async {
    var response = await http.get(
        Uri.parse(
            API_SOCIAL_PROFILE_URL + "get-profile-info/$email"),
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
}
