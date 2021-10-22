import 'dart:convert';

import 'package:flutter_client/models/ChatMessage.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class Friends {
  final String? idUser;
  final String? name;
  final DateTime? lastMessageTime;
  final String? urlAvatar;
  final List<ChatMessage> chatMessage;

  Friends(
      {this.idUser,
      required this.name,
      required this.lastMessageTime,
      required this.urlAvatar,
      required this.chatMessage});

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'lastMessageTime': lastMessageTime.toString(),
        'urlAvatar': urlAvatar
      };

  copyWith(
          {String? idUser,
          String? name,
          String? urlAvatar,
          DateTime? lastMessageTime,
          List<ChatMessage>? chatMessage}) =>
      Friends(
          idUser: idUser,
          name: name,
          lastMessageTime: lastMessageTime,
          urlAvatar: urlAvatar,
          chatMessage: chatMessage == null ? [] : chatMessage);
}

class User {
  final String? idUser;
  final String? name;
  final String? urlAvatar;
  final List<Friends> friends;

  const User(
      {this.idUser,
      required this.name,
      required this.urlAvatar,
      required this.friends});

  User copyWith(
          {String? idUser,
          String? name,
          String? urlAvatar,
          List<Friends>? friends}) =>
      User(
        idUser: idUser,
        name: name,
        urlAvatar: urlAvatar,
        friends: friends == null ? [] : friends,
      );

  static User fromJson(Map<String, dynamic> json) => User(
      idUser: json['idUser'],
      name: json['name'],
      urlAvatar: json['urlAvatar'],
      friends: []);

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'urlAvatar': urlAvatar,
      };
}
