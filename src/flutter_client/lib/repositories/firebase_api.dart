// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_client/constants.dart';
// import 'package:flutter_client/models/Message.dart';
// import 'package:flutter_client/models/User.dart';
// import 'package:flutter_client/models/UserFriend.dart';
// import 'package:flutter_client/presentation/Chat/messages/components/message.dart';
// import 'package:flutter_client/utils.dart';

// class FireBaseApi {
//   static Stream<List<User>> getUsers() => FirebaseFirestore.instance
//       .collection(USER_COLLECTION)
//       .snapshots()
//       .transform(Utils.transformer2(User.fromJson2)
//           as StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
//               List<User>>);

//   static Future addRandomUsers(List<User> users) async {
//     final refUsers =
//         FirebaseFirestore.instance.collection(USER_COLLECTION);

//     final allUsers = await refUsers.get();
//     if (allUsers.size != 0) {
//       return;
//     } else {
//       for (final user in users) {
//         final userDoc = refUsers.doc();
//         final newUser = user.copyWith(
//           id: 2,
//           urlAvatar: user.urlAvatar,
//           nick: user.nick,
//           friends: user.friends,
//         );

//         final firebaseFriend = userDoc.collection(FRIEND_COLLECIONT);

//         final allFriends = await firebaseFriend.get();
//         if (allFriends.size != 0) {
//           return;
//         } else {
//           for (final frie in user.friends) {
//             final friendFirebase = firebaseFriend.doc();
//             final newFriend = frie.copyWith(
//               id: 2,
//               nick: frie.nick,
//               lastMessageTime: frie.lastLogin,
//               urlAvatar: frie.urlAvatar,
//             );

//             final messagesFirebase =
//                 friendFirebase.collection('message');

//             final allMessage = await messagesFirebase.get();
//             if (allMessage.size != 0) {
//               return;
//             } else {
//               // for (final chat in frie.chatMessage) {
//               //   final chatFireBase = messagesFirebase.doc();
//               //   final newChats = chat.copyWith(
//               //       idChat: chatFireBase.id,
//               //       user: chat.user,
//               //       text: chat.text,
//               //       date: chat.date,
//               //       messageStatus: chat.messageStatus,
//               //       isSender: chat.isSender,
//               //       messageType: chat.messageType);

//               //   var a = newChats.toJson();
//               //   await chatFireBase.set(a);
//               // }
//             }

//             var a = newFriend.toJson();
//             await friendFirebase.set(a);
//           }
//         }

//        // print(user.friends[0].chatMessage[0].text);
//         var a = newUser.toJson();
//         print(a);
//         await userDoc.set(a);
//       }
//     }
//   }

//   static Future addRandomMessages(List<Message> users) async {
//     final refUsers =
//         FirebaseFirestore.instance.collection('messages');

//     final allUsers = await refUsers.get();
//     if (allUsers.size != 0) {
//       return;
//     } else {
//       for (final user in users) {
//         final userDoc = refUsers.doc();

//         //   await userDoc.set(user);
//       }
//     }
//   }

//   static Future newUserAfterRegister(
//       String uid, String userName) async {
//     final refUsers =
//         FirebaseFirestore.instance.collection(USER_COLLECTION);
//     final userDoc = refUsers.doc(uid);
//     final newUser = User.copyWithStatic(
//       id: 2,
//       urlAvatar:
//           "https://images.unsplash.com/photo-1496203695688-3b8985780d6a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=641&q=80",
//       nick: userName,
//       friends: [],
//     );
//     var a = newUser.toJson();
//     print(a);
//     await userDoc.set(a);
//   }

//   static Future addNewFriend(String userUid, String userName) async {
//     await FirebaseFirestore.instance
//         .collection(USER_COLLECTION)
//         .get()
//         .then((value) => {
//               if (value.docs.length > 0)
//                 {
//                   doSomething(
//                       userUid,
//                       value.docs
//                           .where((element) =>
//                               element.get('name') == userName)
//                           .first
//                           .data())
//                 }
//             });
//     // .then((value) => value.docs.map((DocumentSnapshot document) {
//     //       print("!!!!!!!!!!!!!!!!!!!START!!!!!!!!!!!!!!!!!!!!!");
//     //       print(document);

//     //       print("!!!!!!!!!!!!!!!!!!!KONIEC!!!!!!!!!!!!!!!!!!!!");

//     //       Map<String, dynamic> data =
//     //           document.data()! as Map<String, dynamic>;

//     //       print("!!!!!!!!!!!!!!!!!!!START!!!!!!!!!!!!!!!!!!!!!");
//     //       print(data);

//     //       print("!!!!!!!!!!!!!!!!!!!KONIEC!!!!!!!!!!!!!!!!!!!!");
//     //       return Friends.fromJson(data);
//     //     }));
//     //  .doc(userUid)
//     //  .collection('friends');
//   }

//   static doSomething(
//       String userUid, Map<String, dynamic> user) async {
//     if (user != null) {
//       final UserFriend newFriend = UserFriend.fromJson(user);
//       final friendFirebase = FirebaseFirestore.instance
//           .collection(USER_COLLECTION)
//           .doc(userUid)
//           .collection(FRIEND_COLLECIONT)
//           .doc();

//       var a = newFriend.toJson();
//       await friendFirebase.set(a);

//       final friendFirebas2e = FirebaseFirestore.instance
//           .collection(USER_COLLECTION)
//           .doc(userUid)
//           .get()
//           .then((value) => {
//                 addMeToFriend(
//                     value.data()!, "newFriend.idUser")
//               });
//     }

//     //var friend = Friends.fromJson(docs.metadata);
//   }

//   static addMeToFriend(
//       Map<String, dynamic> user, String friendUid) async {
//     final UserFriend newFriend = UserFriend.fromJson(user);
//     final friendFirebase = FirebaseFirestore.instance
//         .collection(USER_COLLECTION)
//         .doc(friendUid)
//         .collection(FRIEND_COLLECIONT)
//         .doc();

//     var a = newFriend.toJson();
//     await friendFirebase.set(a);
//   }
// }
