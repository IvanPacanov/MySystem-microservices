// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ChatMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) => ChatMessage(
      idChat: json['idChat'] as String?,
      user: json['user'] as String?,
      text: json['text'] as String?,
      messageStatus:
          $enumDecodeNullable(_$MessageStatusEnumMap, json['messageStatus']),
      isSender: json['isSender'] as bool?,
      messageType:
          $enumDecodeNullable(_$MessageTypeEnumMap, json['messageType']),
      date: json['date'] as String?,
    );

Map<String, dynamic> _$ChatMessageToJson(ChatMessage instance) =>
    <String, dynamic>{
      'idChat': instance.idChat,
      'user': instance.user,
      'text': instance.text,
      'messageStatus': _$MessageStatusEnumMap[instance.messageStatus],
      'messageType': _$MessageTypeEnumMap[instance.messageType],
      'isSender': instance.isSender,
      'date': instance.date,
    };

const _$MessageStatusEnumMap = {
  MessageStatus.not_sent: 'not_sent',
  MessageStatus.not_view: 'not_view',
  MessageStatus.viewed: 'viewed',
};

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
};
