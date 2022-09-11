import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_client/models/ChatMessage.dart';

import 'UserFriend.dart';

import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

@JsonSerializable()
class User {
  final int? id;
  final String? nick;
  final String? email;
  final bool isGuardian;
  final String? guardianEmail;
  final String? urlAvatar;
  final List<UserFriend> friends;

  const User(
      {this.id,
      this.guardianEmail,
      required this.nick,
      required this.email,
      required this.isGuardian,
      required this.urlAvatar,
      required this.friends});

  User copyWith(
          {int? id,
          String? nick,
          String? email,
          required bool isGuardian,
          String? urlAvatar,
          List<UserFriend>? friends}) =>
      User(
        id: id,
        nick: nick,
        email: email,
        isGuardian: isGuardian,
        urlAvatar: urlAvatar,
        friends: friends == null ? [] : friends,
      );

  static User copyWithStatic(
          {int? id,
          String? nick,
          String? email,
          required bool isGuardian,
          String? urlAvatar,
          List<UserFriend>? friends}) =>
      User(
        id: id,
        nick: nick,
        email: email,
        isGuardian: isGuardian,
        urlAvatar: urlAvatar,
        friends: friends == null ? [] : friends,
      );

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  // static User fromJson2(Map<String, dynamic> json) => User(
  //     id: json['idUser'],
  //     nick: json['name'],
  //     email: json['email'],
  //     urlAvatar: json['urlAvatar'],
  //     friends: []);

  // Map<String, dynamic> toJson() => {
  //       'idUser': idUser,
  //       'name': name,
  //       'urlAvatar': urlAvatar,
  //     };
}
