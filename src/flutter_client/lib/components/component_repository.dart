import 'package:cloud_firestore/cloud_firestore.dart';

class ComponentRepository {
  // Stream getUser() async{
  //   final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('users').snapshots();
  // }

  Stream<QuerySnapshot> get getListOfFriends {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('lMmppJhcSKPVB5A5ZQSN')
        .collection('friends')
        .snapshots();
  }

  Stream<QuerySnapshot> get getMessagesOfUser {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('lMmppJhcSKPVB5A5ZQSN')
        .collection('friends')
        .doc('eifqPljYAp2UmrCmMkxZ')
        .collection('message')
        .snapshots();
  }
}
