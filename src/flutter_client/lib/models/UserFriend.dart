import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_client/models/ChatMessage.dart';
import 'package:json_annotation/json_annotation.dart';

import 'NewChat.dart';

part 'UserFriend.g.dart';

@JsonSerializable()
class UserFriend {
  final int? id;
  final String? nick;
  final String? email;
  final String? urlAvatar;
  final String? guardianEmail;
  late bool? isOnline;
  final String? lastLogin;
  final bool? requestedByUser;
  final FriendRequestFlag approved;
  // ignore: avoid_init_to_null
  late String? connectionId = null;
  final List<NewChat>? chats;

  UserFriend(
      {this.id,
      this.isOnline,
      required this.nick,
      required this.email,
      required this.lastLogin,
      required this.guardianEmail,
      required this.urlAvatar,
      required this.requestedByUser,
      required this.approved,
      required this.chats});

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

  copyWith(FriendRequestFlag approved,
          {int? id,
          String? nick,
          String? email,
          String? urlAvatar,
          String? lastMessageTime,
          String? guardianEmail,
          bool? requestedByUser,
          List<NewChat>? chats}) =>
      UserFriend(
          id: id,
          nick: nick,
          email: email,
          lastLogin: lastLogin,
          urlAvatar: urlAvatar,
          guardianEmail: guardianEmail,
          approved: approved,
          requestedByUser: requestedByUser,
          chats: chats);
}

enum FriendRequestFlag { None, Approved, Rejected, Blocked, Spam }
