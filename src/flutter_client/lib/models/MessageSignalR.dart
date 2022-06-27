import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'MessageSignalR.g.dart';

@JsonSerializable()
class MessageSignalR {
  final int userId;
  final String text;
  final bool read;
  final String send;

  MessageSignalR(
      {required this.userId,
      required this.text,
      required this.read,
      required this.send});

  factory MessageSignalR.fromJson(Map<String, dynamic> json) =>
      _$MessageSignalRFromJson(json);

  Map<String, dynamic> toJson() => _$MessageSignalRToJson(this);
}
