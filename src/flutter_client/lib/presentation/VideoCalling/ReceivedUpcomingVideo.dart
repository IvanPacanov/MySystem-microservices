import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:provider/src/provider.dart';
import 'package:sdp_transform/sdp_transform.dart';

class ReceivedUpcomingVideo extends StatefulWidget {
  // final RTCVideoRenderer remoteRenderer;
  // final RTCPeerConnection peerConnection;
  // final SignalRProvider signalRProvider;
  final String offer;
  final String uid;
  ReceivedUpcomingVideo({
    Key? key,
    required this.uid,
    required this.offer,
  }) : super(key: key);

  @override
  _ReceivedUpcomingVideoState createState() =>
      _ReceivedUpcomingVideoState(
        offer: offer,
        uid: uid,
      );
}

class _ReceivedUpcomingVideoState
    extends State<ReceivedUpcomingVideo> {
  late RTCPeerConnection peerConnection;
  late RTCVideoRenderer remoteRenderer = new RTCVideoRenderer();
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
      {required this.uid, required this.offer});

  @override
  initState() {
    initRenders();
    _createPeerConnecion().then((pc) {
      peerConnection = pc;
      _setRemoteDescription();
    });
    super.initState();
  }

  initRenders() async {
    await remoteRenderer.initialize();
  }

  @override
  void dispose() {
    remoteRenderer.dispose();
    // sdpController.dispose();
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
      remoteRenderer.srcObject = stream;
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
                onPressed: () {
                  remoteRenderer.dispose();
                  peerConnection.dispose();
                  context
                      .read<AuthenticatedSessionCubit>()
                      .lastState();
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
      context.read<SignalRProvider>().sendCandidate(arr, uid);

      await Future.delayed(Duration(seconds: 2));
      refresh(context);
    }
  }
}
