import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/VideoCalling/VideoCall2.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class InComingCall extends StatefulWidget {
  const InComingCall({Key? key, required this.callingUser})
      : super(key: key);
  final UserFriend callingUser;

  @override
  State<InComingCall> createState() =>
      _InComingCallState(callingUser: callingUser);
}

class _InComingCallState extends State<InComingCall> {
  final _remoteRenderer = new RTCVideoRenderer();
  late RTCPeerConnection _peerConnection;
  final sdpController = TextEditingController();

  final UserFriend callingUser;

  _InComingCallState({required this.callingUser});

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
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            height: double.infinity,
            child: Row(
              children: <Widget>[
                Text(callingUser.nick!),
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage:
                      NetworkImage(callingUser.urlAvatar!),
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 120,
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              width: 250,
              child: RawMaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoCall2(
                            friend: callingUser,
                            peerConnection: _peerConnection,
                            remoteRenderer: _remoteRenderer),
                      ));
                },
                fillColor: Colors.green,
                child: Icon(
                  Icons.call_rounded,
                  color: Colors.white,
                  size: 35.0,
                ),
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 120,
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              width: 250,
              child: RawMaterialButton(
                onPressed: () {},
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
