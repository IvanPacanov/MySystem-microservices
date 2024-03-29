import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/models/Message.dart';
import 'package:flutter_client/models/MessageSignalR.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/Chat/messages/message_screen.dart';
import 'package:flutter_client/services/SignalR_Services.dart';
import 'package:flutter_client/session/chatSession/chatSession_state.dart';

class AuthenticatedSessionCubit
    extends Cubit<AuthenticatedSessionState> {
  final SignalRProvider signalRProvider;
  final AuthServices authServices;
  late User user;

  late Function() onFriendsUpdatedCallback;
  //late Function() onUpdatedFriend;
  late Function() onRemovedInvitation;

  List<AuthenticatedSessionState> stateList = [];

  AuthenticatedSessionCubit({
    required this.authServices,
    required this.signalRProvider,
  }) : super(NormalState()) {
    user = authServices.user;
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

    signalRProvider.onRingingInterrupted =
        (data) => ringingInterrupted(data);
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

    //onUpdatedFriend();
  }

  void _testElo(dynamic testItem) {
    var userHelp =
        user.friends.where((z) => z.email == testItem['email']).first;

    int index = user.friends.indexOf(userHelp);
    user.friends[index].connectionId = testItem['ConnectionId'];
    user.friends[index].isOnline = testItem['IsActive'] as bool;
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

  void openGuardianView() {
    this.stateList.add(GuardianViewState(user: user));
    emit(GuardianViewState(user: user));
  }

  void openMessageView(UserFriend friend) {
    this.stateList.add(MessageViewState(friend: friend));
    emit(MessageViewState(friend: friend));
  }

  void lastState() {
    stateList.removeLast();
    emit(stateList.last);
  }

  void pickUpPhone(String uid, String offer) {
    emit(ReceivedUpcomingVideoState(uid: uid, offer: offer));
  }

  void goToVideoCall(UserFriend friend) {
    emit(VideoCallState(friend: friend));
  }

  void ringingInterrupted(String connectionId) {
    lastState();
  }

  void rejectCall(UserFriend user) {
    signalRProvider.rejectCall(user);
    lastState();
  }

  void hangUp(UserFriend friend) {
    signalRProvider.hangUp(friend.connectionId!);
    lastState();
  }

  void hangUpConnectionId(String connectionId) {
    signalRProvider.hangUp(connectionId);
    lastState();
  }

  void addNewFriendView() {
    this.stateList.add(FriendViewState());
    emit(FriendViewState());
  }

  void addNewFriend(String userUid, String userName) {}

  void rejectFriend(UserFriend friend) {
    this
        .authServices
        .actionFriendFlag(user.id!, friend.id!, 'Rejected');
  }

  Future<bool> confirmFriend(UserFriend friend) async {
    var result = await authServices.actionFriendFlag(
        user.id!, friend.id!, 'Approved');

    if (result) {
      user = await authServices.getProfile(email: user.email!);
      return true;
    }
    return false;
  }

  void textToSpeech() {
    this.stateList.add(TextToSpeechState());
    emit(TextToSpeechState());
  }

  void cancelInvitation(UserFriend friend) async {
    var result =
        await authServices.cancelInvitation(user.id!, friend.id!);

    if (result) {
      this.user.friends.remove(friend);
      onRemovedInvitation();
    }
  }

  void statusGuardianOk() {}

  
  void statusGuardianNotOk() {}
}
