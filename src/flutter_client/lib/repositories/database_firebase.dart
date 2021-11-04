import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_client/constants.dart';

class FirStoreeDataBaseService {
  final String uid;

  FirStoreeDataBaseService({required this.uid});

  final CollectionReference userChat =
      FirebaseFirestore.instance.collection(USER_COLLECTION);

  Future updateUserData(String name) async {
    return await userChat.doc(uid).set({
      'name': name,
    });
  }

  Future updateFriendCollection() async {

    await userChat
        .doc(uid)
        .collection(FRIEND_COLLECIONT)
        .doc("Admin1")
        .set({"img": "IMGGGG"});
  }
}
