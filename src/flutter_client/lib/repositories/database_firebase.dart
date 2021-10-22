import 'package:cloud_firestore/cloud_firestore.dart';

class FirStoreeDataBaseService {
  final String uid;

  FirStoreeDataBaseService({required this.uid});

  final CollectionReference userChat =
      FirebaseFirestore.instance.collection('Users');

  Future updateUserData(String name) async {
    return await userChat.doc(uid).set({
      'name': name,
    });
  }

  Future updateFriendCollection() async {

    await userChat
        .doc(uid)
        .collection("friends")
        .doc("Admin1")
        .set({"img": "IMGGGG"});
  }
}
