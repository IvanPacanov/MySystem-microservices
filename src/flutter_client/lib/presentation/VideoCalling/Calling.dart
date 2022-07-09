import 'package:flutter/material.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:provider/src/provider.dart';

class Calling extends StatelessWidget {
  const Calling({Key? key, required this.callingUser})
      : super(key: key);
  final UserFriend callingUser;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Calling...",
            style: TextStyle(color: Colors.white),
          ),
          Positioned(
            bottom: 10,
            right: 120,
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              width: 250,
              child: RawMaterialButton(
                onPressed: () {
                  context
                      .read<SignalRProvider>()
                      .stopCallingToUser(callingUser.connectionId);
                  Navigator.pop(context);
                },
                fillColor: Colors.red,
                child: Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 35.0,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class _InComingCallState extends State<InComingCall> {
//   final UserFriend callingUser;

//   _InComingCallState({required this.callingUser});

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             child: Row(
//               children: <Widget>[
//                 Text(callingUser.nick!),
//                 CircleAvatar(
//                   radius: 60.0,
//                   backgroundImage:
//                       NetworkImage(callingUser.urlAvatar!),
//                   backgroundColor: Colors.transparent,
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: 120,
//             child: Container(
//               margin:
//                   EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//               width: 250,
//               child: RawMaterialButton(
//                 onPressed: () {},
//                 fillColor: Colors.green,
//                 child: Icon(
//                   Icons.call_rounded,
//                   color: Colors.white,
//                   size: 35.0,
//                 ),
//                 padding: EdgeInsets.all(15.0),
//                 shape: CircleBorder(),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             right: 120,
//             child: Container(
//               margin:
//                   EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//               width: 250,
//               child: RawMaterialButton(
//                 onPressed: () {},
//                 fillColor: Colors.red,
//                 child: Icon(
//                   Icons.call_end,
//                   color: Colors.white,
//                   size: 35.0,
//                 ),
//                 padding: EdgeInsets.all(15.0),
//                 shape: CircleBorder(),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
