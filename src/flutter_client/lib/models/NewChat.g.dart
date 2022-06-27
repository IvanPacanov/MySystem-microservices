// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewChat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewChat _$NewChatFromJson(Map<String, dynamic> json) => NewChat(
      id: json['id'] as int?,
      created: json['created'] as String?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewChatToJson(NewChat instance) => <String, dynamic>{
      'id': instance.id,
      'created': instance.created,
      'messages': instance.messages,
    };
