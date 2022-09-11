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
      approved: EnumToString.fromString<FriendRequestFlag>(
          FriendRequestFlag.values, json['approved'])!,
      lastLogin: json['lastLogin'] as String?,
      urlAvatar: json['urlAvatar'] as String?,
      requestedByUser: json['requestedByUser'] as bool?,
      guardianEmail: json['guardianEmail'] as String?,
      chats: (json['chats'] as List<dynamic>?)
          ?.map((e) => NewChat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserFriendToJson(UserFriend instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nick': instance.nick,
      'email': instance.email,
      'urlAvatar': instance.urlAvatar,
      'isOnline': instance.isOnline,
      'lastLogin': instance.lastLogin,
      'approved': instance.approved,
      'guardianEmail': instance.guardianEmail,
      'chats': instance.chats,
      'requestedByUser': instance.requestedByUser
    };
