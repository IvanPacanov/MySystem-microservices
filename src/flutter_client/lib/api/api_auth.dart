import 'dart:convert';

import 'package:flutter_client/environments/environments.dart';
import 'package:http/http.dart' as http;

class ApiAuth {
  Future<dynamic> login(
      {required String userName, required String password}) async {
    var response = await http.post(
      Uri.parse(API_AUTH_URL + "user-login-token"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': userName,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<bool> registration(
      {required String userName,
      required String email,
      required String password}) async {
    var response = await http.post(
      Uri.parse(API_AUTH_URL + "user-register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': userName,
        'password': password,
        'email': email
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<bool> confirmCode(
      {required String code, required String userId}) async {
    var response = await http.get(
      Uri.parse(API_AUTH_URL + "user-confirm/$code/$userId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
