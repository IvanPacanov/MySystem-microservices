// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      nick: json['nick'] as String?,
      email: json['email'] as String?,
      urlAvatar: json['urlAvatar'] as String?,
      friends: (json['friends'] as List<dynamic>)
          .map((e) => UserFriend.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nick': instance.nick,
      'email': instance.email,
      'urlAvatar': instance.urlAvatar,
      'friends': instance.friends,
    };
