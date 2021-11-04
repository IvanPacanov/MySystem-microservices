import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({Key? key}) : super(key: key);

  @override
  _VideoCallState createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  bool _offer = false;
  late RTCPeerConnection _peerConnection;
  final _remoteRenderer = new RTCVideoRenderer();

  final sdpController = TextEditingController();

  @override
  void dispose() {
    _remoteRenderer.dispose();
    sdpController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print("INIT STATE !!!!!!!!!!!!!!!!!!!");
    initRenders();
    _createPeerConnecion().then((pc) {
      print("ASYNC!!!!");
      _peerConnection = pc;
    });
    super.initState();
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

    //  _localRenderer.srcObject = stream;
    //  RTCVideoView(_localRenderer);

    return stream;
  }

  initRenders() async {
    // await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  SizedBox videoRenders() => SizedBox(
        height: 210,
        child: Column(
          children: [
            Flexible(
              child: Container(
                key: Key('remote'),
                decoration: BoxDecoration(color: Colors.black),
                child: RTCVideoView(_remoteRenderer),
              ),
            )
          ],
        ),
      );

  void _createOffer() async {
    RTCSessionDescription description =
        await _peerConnection.createOffer({'offerToReceiveVideo': 1});
    var session = parse(description.sdp.toString());
    var t = json.encode(session);

    _offer = true;

    _peerConnection.setLocalDescription(description);
  }

  void _createAnswer() async {
    RTCSessionDescription description = await _peerConnection
        .createAnswer({'offerToReceiveVideo': 1});

    var session = parse(description.sdp.toString());
    var t = json.encode(session);
    print(t);

    _peerConnection.setLocalDescription(description);
  }

  void _setRemoteDescription() async {
    String jsonString = sdpController.text;
    dynamic session = await jsonDecode('$jsonString');

    String sdp = write(session, null);

    RTCSessionDescription description =
        new RTCSessionDescription(sdp, _offer ? 'answer' : 'offer');
    print(description.toMap());

    await _peerConnection.setRemoteDescription(description);
  }

  void _addCandidate() async {
    String jsonString = sdpController.text;
    dynamic session = await jsonDecode('$jsonString');
    print(session['candidate']);
    dynamic candidate = new RTCIceCandidate(session['candidate'],
        session['sdpMid'], session['sdpMlineIndex']);
    await _peerConnection.addCandidate(candidate);
  }

  Row offerAndAnswerButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            onPressed: _createOffer,
            child: Text('Offer'),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.amber)),
          ),
          ElevatedButton(
            onPressed: _createAnswer,
            child: Text('Answer'),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.amber)),
          )
        ],
      );

  Padding sdpCandidateTF() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: sdpController,
          keyboardType: TextInputType.multiline,
          maxLines: 4,
          maxLength: TextField.noMaxLength,
        ),
      );

  Row sdpCandidateButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            onPressed: _setRemoteDescription,
            child: Text('Set Remote Desc.'),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.amber)),
          ),
          ElevatedButton(
            onPressed: _addCandidate,
            child: Text('Set Candidate.'),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.amber)),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          videoRenders(),
          offerAndAnswerButtons(),
          sdpCandidateTF(),
          sdpCandidateButtons(),
        ],
      ),
    );
  }
}
