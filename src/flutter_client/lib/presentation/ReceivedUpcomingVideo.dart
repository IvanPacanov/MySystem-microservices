import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart';

class ReceivedUpcomingVideo extends StatefulWidget {
  final RTCVideoRenderer remoteRenderer;
  final RTCPeerConnection peerConnection;
  final SignalRProvider signalRProvider;
  final String offer;
  final String uid;
  const ReceivedUpcomingVideo(
      {Key? key,
      required this.remoteRenderer,
      required this.uid,
      required this.offer,
      required this.signalRProvider,
      required this.peerConnection})
      : super(key: key);

  @override
  _ReceivedUpcomingVideoState createState() =>
      _ReceivedUpcomingVideoState(
          offer: offer,
          signalRProvider: signalRProvider,
          remoteRenderer: remoteRenderer,
          uid: uid,
          peerConnection: peerConnection);
}

class _ReceivedUpcomingVideoState
    extends State<ReceivedUpcomingVideo> {
  final RTCPeerConnection peerConnection;
  final RTCVideoRenderer remoteRenderer;
  final SignalRProvider signalRProvider;
  final String uid;
  final String offer;
  bool _offer = false;
  double mar = 1;
  void refresh(dynamic childValue) {
    setState(() {
      mar = 2;
    });
  }

  var arr = [];

  _ReceivedUpcomingVideoState(
      {required this.remoteRenderer,
      required this.peerConnection,
      required this.uid,
      required this.signalRProvider,
      required this.offer});

  void _setRemoteDescription() async {
    String jsonString = offer;
    dynamic session = await jsonDecode('$jsonString');

    String sdp = write(session, null);

    RTCSessionDescription description =
        new RTCSessionDescription(sdp, _offer ? 'answer' : 'offer');

    var help = description.toMap();
    print(help);

    await peerConnection.setRemoteDescription(description);
    await _createAnswer();
    await Future.delayed(Duration(seconds: 1));
    await peerConnection
        .getLocalDescription()
        .then((value) => makeMeGood(value!));
  }

  Future<void> _createAnswer() async {
    RTCSessionDescription description =
        await peerConnection.createAnswer({'offerToReceiveVideo': 1});
    var session = parse(description.sdp.toString());
    var t = json.encode(session);
    arr = [];
    arr.add(t);

    await peerConnection.setLocalDescription(description);
  }

  void _addCandidate() async {
    String jsonString = "sdpController.text";
    dynamic session = await jsonDecode('$jsonString');
    print(session['candidate']);
    dynamic candidate = new RTCIceCandidate(session['candidate'],
        session['sdpMid'], session['sdpMlineIndex']);
    await peerConnection.addCandidate(candidate);
  }

  @override
  Widget build(BuildContext context) {
    _setRemoteDescription();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(mar),
            key: Key('local'),
            decoration: BoxDecoration(color: Colors.black),
            child: RTCVideoView(remoteRenderer),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              width: double.infinity,
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
          ),
        ],
      ),
    );
  }

  makeMeGood(RTCSessionDescription value) async {
    if (value.sdp!.contains("candidate")) {
      print("ZAWIERAAAAAAA");
      var c = value.sdp;
      LineSplitter ls = new LineSplitter();
      var a = ls.convert(c!);
      arr.add(a[10].substring(2));
      signalRProvider.sendCandidate(arr, uid);

      await Future.delayed(Duration(seconds: 2));
      refresh(context);
    }
  }
}
