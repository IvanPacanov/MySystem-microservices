import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/VideoCall.dart';
import 'package:flutter_client/presentation/VideoCall2.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'components/body.dart';

class MessageScreen extends StatefulWidget {
  final UserFriend friend;
  const MessageScreen({Key? key, required this.friend})
      : super(key: key);

  @override
  _MessageScreen createState() => _MessageScreen(friend: friend);
}

class _MessageScreen extends State<MessageScreen> {
  final UserFriend friend;
  _MessageScreen({required this.friend});
  final _remoteRenderer = new RTCVideoRenderer();
  late RTCPeerConnection _peerConnection;
  final sdpController = TextEditingController();

  @override
  initState() {
    initRenders();
    _createPeerConnecion().then((pc) {
      _peerConnection = pc;
    });
    super.initState();   
  }

  initRenders() async {
    await _remoteRenderer.initialize();
  }

  @override
  void dispose() {
    _remoteRenderer.dispose();
    sdpController.dispose();
    super.dispose();
  }

  _createPeerConnecion() async {
    Map<String, dynamic> configuration = {
      "iceServers": [
        {"url": "stun:stun.l.google.com:19302"},
      ]
    };

    final Map<String, dynamic> offerSdpConstraints = {
      "mandatory": {
        "OfferToReceiveAudio": true,
        "OfferToReceiveVideo": true,
      },
      "optional": [],
    };

    RTCPeerConnection pc = await createPeerConnection(
        configuration, offerSdpConstraints);

    pc.addStream(await _getUserMedia());

    pc.onIceCandidate = (e) {
      if (e.candidate != null) {
        print(json.encode({
          'candidate': e.candidate.toString(),
          'sdpMid': e.sdpMid.toString(),
          'sdpMlineIndex': e.sdpMlineIndex,
        }));
      }
    };

    pc.onIceConnectionState = (e) {
      print(e);
    };

    pc.onAddStream = (stream) {
      print('addStream: ' + stream.id);
      _remoteRenderer.srcObject = stream;
    };

    return pc;
  }

  _getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': false,
      'video': {
        'facingMode': 'user',
      },
    };

    MediaStream stream =
        await navigator.mediaDevices.getUserMedia(mediaConstraints);

    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/dog.png"),
          ),
          SizedBox(width: defaulPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                friend.nick!,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Active 3m ago",
                style: TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.local_phone),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoCall2(
                      friend: friend,
                      peerConnection: _peerConnection,
                      remoteRenderer: _remoteRenderer),
                ));
          },
          icon: Icon(Icons.videocam),
        ),
        SizedBox(
          width: defaulPadding / 2,
        )
      ],
    );
  }
}
