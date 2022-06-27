// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageSignalR.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageSignalR _$MessageSignalRFromJson(Map<String, dynamic> json) =>
    MessageSignalR(
      userId: json['userId'] as int,
      text: json['text'] as String,
      read: json['read'] as bool,
      send: json['send'] as String,
    );

Map<String, dynamic> _$MessageSignalRToJson(MessageSignalR instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'text': instance.text,
      'read': instance.read,
      'send': instance.send,
    };
