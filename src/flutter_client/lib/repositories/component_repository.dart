// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_client/constants.dart';
// import 'package:flutter_client/repositories/firebase_api.dart';

// class ComponentRepository {


//   Stream<QuerySnapshot> getListOfFriends(String uid) {
//     return FirebaseFirestore.instance
//         .collection(USER_COLLECTION)
//         .doc(uid)
//         .collection(FRIEND_COLLECIONT)
//         .snapshots();
//   }

//   Stream<QuerySnapshot> getMessagesOfUser(
//       String uid, String friendUid) {
//     return FirebaseFirestore.instance
//         .collection(USER_COLLECTION)
//         .doc(uid)
//         .collection(FRIEND_COLLECIONT)
//         .doc(friendUid)
//         .collection(MESSAGE_COLLECTION)
//         .snapshots();
//   }

//   void addNewFriend(String userUid, String userName) {
//     FireBaseApi.addNewFriend(userUid, userName);
//   }
// }
