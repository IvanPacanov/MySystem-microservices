// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      userId: json['userId'] as int,
      text: json['text'] as String,
      read: json['read'] as bool,
      send: json['send'] as String,
      received: json['received'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'userId': instance.userId,
      'text': instance.text,
      'read': instance.read,
      'send': instance.send,
      'received': instance.received,
      'messageType': _$MessageTypeNewEnumMap[instance.messageType],
    };

const _$MessageTypeNewEnumMap = {
  MessageTypeNew.text: 'text',
};
