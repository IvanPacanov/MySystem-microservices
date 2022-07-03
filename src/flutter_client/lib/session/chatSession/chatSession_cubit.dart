import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/chatSession_state.dart';

class AuthenticatedSessionCubit
    extends Cubit<AuthenticatedSessionState> {
  final SignalRProvider signalRProvider;
  final User user;

  AuthenticatedSessionCubit(
      {required this.signalRProvider, required this.user})
      : super(NormalState()) {
    print(user);
    signalRProvider.initSignalR(user);

    signalRProvider.onComingCalling =
        (offer, uid) => comingCalling(offer, uid);

    signalRProvider.onFriendsUpdateCallback =
        (data) => updateFriendsConnectionID(data);
  }

  void updateFriendsConnectionID(List<dynamic>? data) {
    List<dynamic> test = jsonDecode(data![0]);
    test.forEach((dynamic testItem) => {_testElo(testItem)});
  }

  void _testElo(dynamic testItem) {
    var userHelp = user.friends
        .where((z) => z.email == testItem['email'])
        .first;

    int index = user.friends.indexOf(userHelp);
    user.friends[index].connectionId =
        testItem['ConnectionId'];
  }

  void comingCalling(String offer, String uid) {
    emit(ComingCalling(offer: offer, uid: uid));
  }
}
