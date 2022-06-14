// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserFriend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFriend _$UserFriendFromJson(Map<String, dynamic> json) =>
    UserFriend(
      id: json['id'] as int?,
      isOnline: json['isOnline'] as bool?,
      nick: json['nick'] as String?,
      email: json['email'] as String?,
      lastLogin: json['lastLogin'] as String?,
      urlAvatar: json['urlAvatar'] as String?,
    );

Map<String, dynamic> _$UserFriendToJson(UserFriend instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nick': instance.nick,
      'email': instance.email,
      'urlAvatar': instance.urlAvatar,
      'isOnline': instance.isOnline,
      'lastLogin': instance.lastLogin
    };
