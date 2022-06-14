import 'dart:convert';

import 'package:flutter_client/models/ChatMessage.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserFriend.g.dart';

@JsonSerializable()
class UserFriend {
  final int? id;
  final String? nick;
  final String? email;
  final String? urlAvatar;
  final bool? isOnline;
  final String? lastLogin;
  late String connectionId;
  // final List<ChatMessage> chatMessage;

  UserFriend(
      {this.id,
      this.isOnline,
      required this.nick,
      required this.email,
      required this.lastLogin,
      required this.urlAvatar});

  factory UserFriend.fromJson(Map<String, dynamic> json) =>
      _$UserFriendFromJson(json);

  Map<String, dynamic> toJson() => _$UserFriendToJson(this);

  // Map<String, dynamic> toJson() => {
  //       'idUser': idUser,
  //       'name': name,
  //       'lastMessageTime': lastMessageTime.toString(),
  //       'urlAvatar': urlAvatar,
  //       'confirmed': confirmed == null ? false : confirmed
  //     };

  // static UserFriend fromJson(Map<String, dynamic> json) => UserFriend(
  //     idUser: json['idUser'],
  //     name: json['name'],
  //     urlAvatar: json['urlAvatar'],
  //     lastMessageTime: json['lastMessageTime'],
  //     confirmed: json['confirmed'],
  //     chatMessage: []);

  copyWith(
          {int? id,
          String? nick,
          String? email,
          String? urlAvatar,
          String? lastMessageTime,
          List<ChatMessage>? chatMessage}) =>
      UserFriend(
        id: id,
        nick: nick,
        email: email,
        lastLogin: lastLogin,
        urlAvatar: urlAvatar,
      );
}
