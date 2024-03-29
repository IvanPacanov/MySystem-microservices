import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'dart:async';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';
import 'package:flutter_client/presentation/Chat/chat_view.dart';
import 'package:flutter_client/session/session_cubit.dart';
import 'package:torch_controller/torch_controller.dart';

import '../../blocs/chat/chat_bloc.dart';
import '../../blocs/chat/chat_state.dart';
import '../../models/User.dart';
import '../../models/UserFriend.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  final torchController = TorchController();

  static const MethodChannel _channel =
      const MethodChannel('flashlight');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/background-image.jpg"), //photo by Photo by ????
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: <Widget>[
              Flexible(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    _cardElement(_torchButton(context)),
                    _cardElement(_chatButton(context)),
                    _cardElement(_textToSpeech(context)),
                    _cardElement(_logoutButton(context)),
                  ],
                ),
              ),
              _cardElement(_guardianButton(context)),
              _chatContainer()
            ],
          )),
    );
  }

  Widget _cardElement(Widget content) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(150),
      ),
      margin: EdgeInsets.all(8.0),
      child: content,
    );
  }

  Widget _textToSpeech(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AuthenticatedSessionCubit>().textToSpeech();
      },
      child: Container(
        alignment: Alignment.center,
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.orange.shade400, width: 5),
            shape: BoxShape.circle),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hearing_outlined,
                size: 50, color: Colors.orange.shade400),
            Text('Przeczytaj tekst'.toUpperCase()),
          ],
        ),
      ),
    );
  }

  Widget _addFriend(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AuthenticatedSessionCubit>().addNewFriendView();
      },
      child: Container(
        alignment: Alignment.center,
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.orange.shade400, width: 5),
            shape: BoxShape.circle),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add,
                size: 50, color: Colors.orange.shade400),
            Text('Logout'.toUpperCase()),
          ],
        ),
      ),
    );
  }

  logout() {
    context.read<SessionCubit>().logout();
  }

  Widget _logoutButton(BuildContext context) {
    return InkWell(
      onTap: () => showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text("Wylogowanie?"),
          content: Text("Czy na pewno chcesz się wylogować?"),
          actions: [
            CupertinoDialogAction(
              child: Text('Nie'),
              onPressed: (() {
                Navigator.of(context, rootNavigator: true)
                    .pop("Discard");
              }),
            ),
            CupertinoDialogAction(
              child: Text('Tak'),
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pop("Discard");
                logout();
              },
            )
          ],
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.orange.shade400, width: 5),
            shape: BoxShape.circle),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout,
                size: 50, color: Colors.orange.shade400),
            Text('Logout'.toUpperCase()),
          ],
        ),
      ),
    );
  }

  Widget _chatButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AuthenticatedSessionCubit>().openChatView();
      },
      child: Container(
        alignment: Alignment.center,
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.orange.shade400, width: 5),
            shape: BoxShape.circle),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat, size: 50, color: Colors.orange.shade400),
            Text('Wiadomości'.toUpperCase()),
          ],
        ),
      ),
    );
  }

  Widget _guardianButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<AuthenticatedSessionCubit>().openGuardianView();
      },
      child: Container(
        alignment: Alignment.center,
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.orange.shade400, width: 5),
            shape: BoxShape.circle),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.security,
                size: 50, color: Colors.orange.shade400),
            Text('Kontakt z bliskim!'.toUpperCase()),
          ],
        ),
      ),
    );
  }

  Widget _torchButton(BuildContext context) {
    return InkWell(
      onTap: () {
        torchController.toggle(intensity: 1);
        setState(() {});
      },
      child: FutureBuilder(
          future: torchController.isTorchActive,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                    color: snapshot.data as bool
                        ? Colors.yellow.shade100
                        : Colors.white,
                    border: Border.all(
                        color: Colors.orange.shade400, width: 5),
                    shape: BoxShape.circle),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        snapshot.data as bool
                            ? Icons.flashlight_on
                            : Icons.flashlight_off,
                        size: 50,
                        color: Colors.orange.shade400),
                    Text('Latarka'.toUpperCase()),
                  ],
                ),
              );

            return Container();
          }),
    );
  }

  Widget _sizeBoxH10({double value = 10}) {
    return SizedBox(
      height: value,
    );
  }

  Widget _chatContainer() {
    return Container(
      child: Flexible(
        child: BlocProvider(
          create: (context) => ChatBloc(
            authRepository: context
                .read<AuthenticatedSessionCubit>()
                .authServices,
            chatSessionCubit:
                context.read<AuthenticatedSessionCubit>(),
          ),
          child: Scaffold(
            body: Container(
                decoration:
                    BoxDecoration(color: Colors.green.shade300),
                child: _connectionString(context)),
          ),
        ),
      ),
    );
  }

  Widget _connectionString(BuildContext context) {
    int _selectedIndex = 0;
    late User userCred;
    return BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
      userCred = context.read<ChatBloc>().chatSessionCubit.user;
      context.read<ChatBloc>().onUpdatedFriendIsSet = true;
      context.read<ChatBloc>().onUpdatedFriend =
          () => {setState(() {})};
      return Column(
        children: [
          Flexible(
            child: ListView.builder(
                itemCount: userCred.friends.length,
                itemBuilder: (context, index) {
                  return _friendCard(
                      context, userCred.friends[index]);
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Colors.grey.shade700, width: 3),
              ),
              child: IconButton(
                  iconSize: 50,
                  onPressed: () {
                    context
                        .read<AuthenticatedSessionCubit>()
                        .addNewFriendView();
                  },
                  icon: Icon(Icons.person_add)),
            ),
          )
        ],
      );
    });
  }

  Widget _friendCard(BuildContext context, UserFriend friend) {
    return Card(
        color:
            friend.isOnline! ? Colors.green.shade200 : Colors.white,
        child: friend.approved == FriendRequestFlag.Approved
            ? confirmedFriend(friend)
            : unConfirmedFriend(friend));
  }

  Widget unConfirmedFriend(UserFriend friend) {
    context.read<AuthenticatedSessionCubit>().onRemovedInvitation =
        () {
      setState(() {});
    };
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(friend.urlAvatar!),
              backgroundColor: Colors.transparent,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(friend.nick!, style: TextStyle(fontSize: 20)),
                friend.requestedByUser == true
                    ? Row(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AuthenticatedSessionCubit>()
                                  .cancelInvitation(friend);
                            },
                            child: const Text('Anuluj zaproszenie'),
                          ),
                        ],
                      )
                    : Row(
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AuthenticatedSessionCubit>()
                                  .rejectFriend(friend);
                            },
                            child: const Text('Odrzuć'),
                          ),
                          const SizedBox(width: 30),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AuthenticatedSessionCubit>()
                                  .confirmFriend(friend)
                                  .then((value) => setState(() {}));
                              // userCred = context
                              //     .read<ChatBloc>()
                              //     .chatSessionCubit
                              //     .user;
                            },
                            child: const Text('Potwierdź'),
                          ),
                        ],
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget confirmedFriend(UserFriend friend) {
    var messageLength = friend.chats!.length > 0
        ? friend.chats![0].messages!.length
        : 0;
    return IntrinsicHeight(
      child: InkWell(
        onTap: () {
          context
              .read<AuthenticatedSessionCubit>()
              .openMessageView(friend);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(friend.urlAvatar!),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(friend.nick!,
                          style: TextStyle(fontSize: 20)),
                      Text(
                          messageLength > 0
                              ? (messageLength > 0
                                  ? friend
                                      .chats![0]
                                      .messages![messageLength - 1]
                                      .text
                                  : "")
                              : "",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: friend.chats!.length > 0
                                ? (friend.chats![0].messages!.length >
                                        0
                                    ? friend.chats![0].messages![0]
                                            .read
                                        ? FontWeight.normal
                                        : FontWeight.bold
                                    : FontWeight.normal)
                                : FontWeight.normal,
                          )),
                      // Positioned(
                      //     child: Text(friend.lastLogin != null
                      //         ? friend.lastLogin!
                      //         : ""))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
