import 'dart:convert';

import 'package:flutter_client/models/ChatMessage.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Message.dart';

part 'NewChat.g.dart';

@JsonSerializable()
class NewChat {
  final int? id;
  final String? created;
  final List<Message>? messages;

  NewChat({this.id, this.created, required this.messages});

  factory NewChat.fromJson(Map<String, dynamic> json) =>
      _$NewChatFromJson(json);

  Map<String, dynamic> toJson() => _$NewChatToJson(this);

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

  // copyWith(
  //         {int? id,
  //         String? nick,
  //         String? email,
  //         String? urlAvatar,
  //         String? lastMessageTime,
  //         List<ChatMessage>? chatMessage}) =>
  //     UserFriend(
  //         id: id,
  //         nick: nick,
  //         email: email,
  //         lastLogin: lastLogin,
  //         urlAvatar: urlAvatar,
  //         chatMessage: chatMessage);
}
