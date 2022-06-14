import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/blocs/video-call/video_call_bloc.dart';
import 'package:flutter_client/components/chat/chat_bloc.dart';
import 'package:flutter_client/components/component_repository.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/chatSession_cubit.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:sdp_transform/sdp_transform.dart';
import 'package:flutter_client/components/chat/chat_state.dart';
import 'package:flutter_client/blocs/video-call/video_call_state.dart';

class VideoCall2 extends StatefulWidget {
  final UserFriend? friend;
  final RTCVideoRenderer remoteRenderer;
  final RTCPeerConnection peerConnection;
  const VideoCall2(
      {Key? key,
      this.friend,
      required this.remoteRenderer,
      required this.peerConnection})
      : super(key: key);

  @override
  _VideoCallState2 createState() => _VideoCallState2(
      friend: friend,
      remoteRenderer: remoteRenderer,
      peerConnection: peerConnection);
}

class _VideoCallState2 extends State<VideoCall2> {
  final UserFriend? friend;
  _VideoCallState2(
      {required this.friend,
      required this.remoteRenderer,
      required this.peerConnection});

  double mar = 1;
  void refresh(dynamic childValue) {
    setState(() {
      mar = 2;
    });
  }

  bool _offer = false;
  final RTCPeerConnection peerConnection;
  final RTCVideoRenderer remoteRenderer;
  // final sdpController = TextEditingController();

  void _createOffer(BuildContext context) async {
    RTCSessionDescription description =
        await peerConnection.createOffer({'offerToReceiveVideo': 1});
    var session = parse(description.sdp.toString());
    var offer = json.encode(session);
    if (friend?.connectionId != null) {
      SignalRProvider.callToUser(offer, friend!.connectionId);
      _offer = true;
      peerConnection.setLocalDescription(description);
    }
  }

  void _setRemoteDescription(String offerSet) async {
    String jsonString = offerSet;
    dynamic session = await jsonDecode('$jsonString');

    String sdp = write(session, null);

    RTCSessionDescription description =
        new RTCSessionDescription(sdp, _offer ? 'answer' : 'offer');
    print(description.toMap());

    await peerConnection.setRemoteDescription(description);
  }

  void _createAnswer() async {
    RTCSessionDescription description =
        await peerConnection.createAnswer({'offerToReceiveVideo': 1});

    var session = parse(description.sdp.toString());
    var t = json.encode(session);
    print(t);

    peerConnection.setLocalDescription(description);
  }

  void _addCandidate(String candidateString) async {
    String jsonString = candidateString;
    dynamic session = await jsonDecode('$jsonString');
    print(session['candidate']);
    dynamic candidate = new RTCIceCandidate(session['candidate'],
        session['sdpMid'], session['sdpMlineIndex']);
    await peerConnection.addCandidate(candidate);
  }

  // @override
  // void dispose() {
  //   _remoteRenderer.dispose();
  //   sdpController.dispose();
  //   super.dispose();
  // }

  // Future<bool> initState222() async {
  //   print("INITIALIZEEEEE");
  //   initRenders();
  //   await _createPeerConnecion().then((pc) {
  //     _peerConnection = pc;
  //   });
  //   super.initState();

  //   print("INITIALIZEEEEE END");
  //   print(_peerConnection);

  //   return true;
  // }

  // _createPeerConnecion() async {
  //   Map<String, dynamic> configuration = {
  //     "iceServers": [
  //       {"url": "stun:stun.l.google.com:19302"},
  //     ]
  //   };

  //   final Map<String, dynamic> offerSdpConstraints = {
  //     "mandatory": {
  //       "OfferToReceiveAudio": true,
  //       "OfferToReceiveVideo": true,
  //     },
  //     "optional": [],
  //   };

  //   RTCPeerConnection pc = await createPeerConnection(
  //       configuration, offerSdpConstraints);

  //   pc.addStream(await _getUserMedia());

  //   pc.onIceCandidate = (e) {
  //     if (e.candidate != null) {
  //       print(json.encode({
  //         'candidate': e.candidate.toString(),
  //         'sdpMid': e.sdpMid.toString(),
  //         'sdpMlineIndex': e.sdpMlineIndex,
  //       }));
  //     }
  //   };

  //   pc.onIceConnectionState = (e) {
  //     print(e);
  //   };

  //   pc.onAddStream = (stream) {
  //     print('addStream: ' + stream.id);
  //     _remoteRenderer.srcObject = stream;
  //   };

  //   return pc;
  // }

  // _getUserMedia() async {
  //   final Map<String, dynamic> mediaConstraints = {
  //     'audio': false,
  //     'video': {
  //       'facingMode': 'user',
  //     },
  //   };

  //   MediaStream stream =
  //       await navigator.mediaDevices.getUserMedia(mediaConstraints);

  //   return stream;
  // }

  // initRenders() async {
  //   await _remoteRenderer.initialize();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => VideoCallBloc(),
        // componehtRepository: context.read<ComponentRepository>(),
        // authRepository: context.read<AuthRepository>(),
        // chatSessionCubit: context.read<ChatSessionCubit>(),
        // signalR: context.read<SignalRProvider>()),
        child: BlocBuilder<VideoCallBloc, VideoCallState>(
            builder: (context, state) {
          if (friend != null) {
            _createOffer(context);
            SignalRProvider.connection.on('CandidateToConnect',
                (message) async {
              print("ODEBRAŁEM KANDYDATA");
              _setRemoteDescription(message![0]);
              await Future.delayed(Duration(seconds: 1));
              _addCandidate(correctCandidate(message[1]));
              await Future.delayed(Duration(seconds: 1));
              _addCandidate(correctCandidate(message[1]));
              refresh(context);
            });
          }
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
                    margin: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
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
        }));
  }

  String correctCandidate(String message) {
    var mess = "\{\"" +
        message.substring(0, 9) +
        "\"" +
        ":" +
        "\"candidate:" +
        message.substring(11) +
        "\"," +
        '"sdpMid":"video","sdpMlineIndex":0' +
        "\}";

    return mess;
  }
}
