import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/models/Message.dart';
import 'package:flutter_client/models/MessageSignalR.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/Chat/messages/message_screen.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/chatSession_state.dart';

class AuthenticatedSessionCubit
    extends Cubit<AuthenticatedSessionState> {
  final SignalRProvider signalRProvider;
  final AuthServices authServices;
  final User user;

  late Function() onFriendsUpdatedCallback;

  List<AuthenticatedSessionState> stateList = [];

  AuthenticatedSessionCubit(
      {required this.authServices,
      required this.signalRProvider,
      required this.user})
      : super(NormalState()) {
    print(user);
    this.stateList.add(NormalState());
    signalRProvider.initSignalR(user);

    signalRProvider.onComingCalling =
        (offer, uid) => comingCalling(offer, uid);

    signalRProvider.incomingCalling =
        (user, offer) => inComingCalling(user, offer, user);

    signalRProvider.onFriendsUpdateCallback =
        (data) => updateFriendsConnectionID(data);

    signalRProvider.onFriendUpdateCallback =
        (data) => updateFriendConnectionID(data);

    signalRProvider.onReceivedMessageCallback =
        (data) => receivedMessage(data);
  }

  receivedMessage(MessageSignalR data) {
    var user2 = authServices.user.friends
        .where((z) => z.id == data.userId)
        .first;

    int index = authServices.user.friends.indexOf(user2);

    Message message = new Message(
        userId: data.userId,
        text: data.text,
        read: data.read,
        send: data.send);

    user.friends[index].chats![0].messages!.add(message);

    onFriendsUpdatedCallback();
  }

  void updateFriendConnectionID(dynamic? data) {
    print("!!!!! START !!!!! Update friend after login: ");
    print(data);
    print("!!!!! END !!!!!  Update friend after login: ");
    dynamic test = jsonDecode(data);
    _testElo(test);
  }

  void updateFriendsConnectionID(List<dynamic>? data) {
    print("!!!!! START !!!!! Update friends after login: ");
    print(data);
    print("!!!!! END !!!!!  Update friends after login: ");
    List<dynamic> test = jsonDecode(data![0]);
    test.forEach((dynamic testItem) => {_testElo(testItem)});
  }

  void _testElo(dynamic testItem) {
    var userHelp =
        user.friends.where((z) => z.email == testItem['email']).first;

    int index = user.friends.indexOf(userHelp);
    user.friends[index].connectionId = testItem['ConnectionId'];
  }

  void comingCalling(String offer, String uid) {
    emit(ComingCalling(offer: offer, uid: uid));
  }

  void inComingCalling(dynamic data, String offer, String uid) {
    var callingUser =
        user.friends.where((z) => z.connectionId == data).first;
    emit(InComingCalling(
        callingUser: callingUser, offer: offer, uid: uid));
  }

  void openChatView() {
    this.stateList.add(ChatViewState());
    emit(ChatViewState());
  }

  void openMessageView(UserFriend friend) {
    this.stateList.add(MessageViewState(friend: friend));
    emit(MessageViewState(friend: friend));
  }

  void lastState() {
    emit(stateList.last);
  }

  void pickUpPhone(String uid, String offer) {
    emit(ReceivedUpcomingVideoState(uid: uid, offer: offer));
  }
}
