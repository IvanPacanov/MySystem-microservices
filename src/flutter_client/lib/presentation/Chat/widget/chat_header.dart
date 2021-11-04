import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_client/models/User.dart';

class ChatHeaderWidget extends StatelessWidget {
  //final AsyncSnapshot<QuerySnapshot<Object?>> users;

  const ChatHeaderWidget() : super();

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                'ChatsApp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 12),
            //   Container(
            //       height: 60,
            //       child: ListView(
            //         scrollDirection: Axis.horizontal,
            //         children: users.data!.docs
            //             .map((DocumentSnapshot document) {
            //           Map<String, dynamic> data =
            //               document.data()! as Map<String, dynamic>;

            //           return ListTile(
            //             title: Text(data['name']),
            //             leading: CircleAvatar(
            //               radius: 30.0,
            //               backgroundImage:
            //                   NetworkImage(data['urlAvatar']),
            //               backgroundColor: Colors.transparent,
            //             ),
            //           );
            //         }).toList(),
            //       )

            //       // ListView.builder(

            //       //   scrollDirection: Axis.horizontal,
            //       //   itemCount: users.length,
            //       //   itemBuilder: (context, index) {
            //       //     final user = users[index];
            //       //     if (index == 0) {
            //       //       return Container(
            //       //         margin: EdgeInsets.only(right: 12),
            //       //         child: CircleAvatar(
            //       //           radius: 24,
            //       //           child: Icon(Icons.search),
            //       //         ),
            //       //       );
            //       //     } else {
            //       //       return Container(
            //       //         margin: const EdgeInsets.only(right: 12),
            //       //         child: GestureDetector(
            //       //           onTap: () {
            //       //             // Navigator.of(context).push(MaterialPageRoute(
            //       //             //   builder: (context) => ChatPage(user: users[index]),
            //       //             // ));
            //       //           },
            //       //           child: CircleAvatar(
            //       //             radius: 24,
            //       //             backgroundImage:
            //       //                 NetworkImage(user.urlAvatar!),
            //       //           ),
            //       //         ),
            //       //       );
            //       //     }
            //       //   },
            //       // ),
            //       )
          ],
        ),
      );
}
