import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_client/components/chat/messages/components/message.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/utils.dart';

class FireBaseApi {
  static Stream<List<User>> getUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .transform(Utils.transformer2(User.fromJson)
          as StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<User>>);

  static Future addRandomUsers(List<User> users) async {
    final refUsers = FirebaseFirestore.instance.collection('users');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();
        final newUser = user.copyWith(
          idUser: userDoc.id,
          urlAvatar: user.urlAvatar,
          name: user.name,
          friends: user.friends,
        );

        final firebaseFriend = userDoc.collection('friends');

        final allFriends = await firebaseFriend.get();
        if (allFriends.size != 0) {
          return;
        } else {
          for (final frie in user.friends) {
            final friendFirebase = firebaseFriend.doc();
            final newFriend = frie.copyWith(
              idUser: firebaseFriend.id,
              name: frie.name,
              lastMessageTime: frie.lastMessageTime,
              urlAvatar: frie.urlAvatar,
            );

            final messagesFirebase =
                friendFirebase.collection('message');

            final allMessage = await messagesFirebase.get();
            if (allMessage.size != 0) {
              return;
            } else {
              for (final chat in frie.chatMessage) {
                final chatFireBase = messagesFirebase.doc();
                final newChats = chat.copyWith(
                    idChat: chatFireBase.id,
                    user: chat.user,
                    text: chat.text,
                    messageStatus: chat.messageStatus,
                    isSender: chat.isSender,
                    messageType: chat.messageType);

                var a = newChats.toJson();
                await chatFireBase.set(a);
              }
            }

            var a = newFriend.toJson();
            await friendFirebase.set(a);
          }
        }

        print(user.friends[0].chatMessage[0].text);
        var a = newUser.toJson();
        print(a);
        await userDoc.set(a);
      }
    }
  }

  static Future addRandomMessages(List<Message> users) async {
    final refUsers =
        FirebaseFirestore.instance.collection('messages');

    final allUsers = await refUsers.get();
    if (allUsers.size != 0) {
      return;
    } else {
      for (final user in users) {
        final userDoc = refUsers.doc();

        //   await userDoc.set(user);
      }
    }
  }
}
