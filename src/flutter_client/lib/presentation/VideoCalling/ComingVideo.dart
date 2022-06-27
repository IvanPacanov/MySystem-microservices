import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/presentation/VideoCalling/ReceivedUpcomingVideo.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/chatSession_cubit.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class ComingVideo extends StatefulWidget {
  const ComingVideo(
      {Key? key, required this.offer, required this.uid})
      : super(key: key);
  final String offer;

  final String uid;
  @override
  State<ComingVideo> createState() =>
      _ComingVideoState(offer: offer, uid: uid);
}

class _ComingVideoState extends State<ComingVideo> {
  final _remoteRenderer = new RTCVideoRenderer();
  final String offer;
  final String uid;
  late RTCPeerConnection _peerConnection;
  final sdpController = TextEditingController();

  _ComingVideoState({required this.offer, required this.uid});

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
    return BlocProvider(
      create: (context) => SignalRProvider(
          chatSessionCubit:
              context.read<AuthenticatedSessionCubit>()),
      child: BlocBuilder<SignalRProvider, void>(
          builder: (content, asta) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                key: Key('local'),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: Colors.black),
                child: MyStatefulWidget(),
              ),
              Positioned(
                bottom: 10,
                left: 120,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 40),
                  width: 250,
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ReceivedUpcomingVideo(
                                    offer: offer,
                                    signalRProvider: content
                                        .read<SignalRProvider>(),
                                    peerConnection: _peerConnection,
                                    remoteRenderer: _remoteRenderer,
                                    uid: uid),
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
                  margin: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 40),
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
      }),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: FlutterLogo(size: 150.0),
      ),
    );
  }
}
