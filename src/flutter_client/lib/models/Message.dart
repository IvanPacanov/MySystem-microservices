import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'Message.g.dart';

enum MessageTypeNew { text }

@JsonSerializable()
class Message {
  final int userId;
  final String text;
  final bool read;
  final String send;
  final String? received;
  late MessageTypeNew messageType = MessageTypeNew.text;

  Message(
      {required this.userId,
      required this.text,
      required this.read,
      required this.send,
      this.received});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);

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
