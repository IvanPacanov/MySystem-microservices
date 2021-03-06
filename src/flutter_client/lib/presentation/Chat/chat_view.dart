import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/blocs/chat/chat_bloc.dart';
import 'package:flutter_client/blocs/chat/chat_state.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/account/account_screen.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'package:flutter_client/widgets/gradient_button.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  ChatView();

  @override
  State<ChatView> createState() => _ChatView();
}

class _ChatView extends State<ChatView> {
  int _selectedIndex = 0;
  late User userCred;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: _bottomNavigation(),
      body: Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Flexible(
          child: BlocProvider(
            create: (context) => ChatBloc(
              authRepository: context
                  .read<AuthenticatedSessionCubit>()
                  .authServices,
              chatSessionCubit:
                  context.read<AuthenticatedSessionCubit>(),
            ),
            child: Scaffold(
              body: _connectionString(context),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buttton1() {
    return BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
      return GradientButton(
        width: 150,
        height: 50,
        onPressed: () {
          //   context.read<ChatBloc>().active();
        },
        text: Text(
          'Active SignalR',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    });
  }

  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {},
  );

  Widget _connectionString(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
      userCred = context.read<ChatBloc>().chatSessionCubit.user;

      return ListView.builder(
          itemCount: userCred.friends.length,
          itemBuilder: (context, index) {
            return _friendCard(context, userCred.friends[index]);
          });
    });
  }

  Widget _friendCard(BuildContext context, UserFriend friend) {
    return Card(
        color: friend.approved == FriendRequestFlag.Approved
            ? Colors.green.shade200
            : friend.isOnline!
                ? Colors.green.shade200
                : Colors.white,
        child: friend.approved == FriendRequestFlag.Approved
            ? confirmedFriend(friend)
            : unConfirmedFriend(friend));
  }

  Widget unConfirmedFriend(UserFriend friend) {
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
              children: <Widget>[
                Text(friend.nick!, style: TextStyle(fontSize: 20)),
                Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<AuthenticatedSessionCubit>()
                            .rejectFriend(friend);
                      },
                      child: const Text('Odrzu??'),
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
                      child: const Text('Potwierd??'),
                    ),
                  ],
                )
              ],
            ),
            Positioned(
                child: Text(friend.lastLogin != null
                    ? friend.lastLogin!
                    : ""))
          ],
        ),
      ),
    );
  }

  Widget confirmedFriend(UserFriend friend) {
    var messageLength = friend.chats![0].messages!.length;
    return IntrinsicHeight(
      child: InkWell(
        onTap: () {
          context
              .read<AuthenticatedSessionCubit>()
              .openMessageView(friend);
        },
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
                children: <Widget>[
                  Text(friend.nick!, style: TextStyle(fontSize: 20)),
                  Text(
                      messageLength > 0
                          ? (messageLength > 0
                              ? friend.chats![0]
                                  .messages![messageLength - 1].text
                              : "")
                          : "",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: friend.chats!.length > 0
                            ? (friend.chats![0].messages!.length > 0
                                ? friend.chats![0].messages![0].read!
                                    ? FontWeight.normal
                                    : FontWeight.bold
                                : FontWeight.normal)
                            : FontWeight.normal,
                      )),
                ],
              ),
              Positioned(
                  child: Text(friend.lastLogin != null
                      ? friend.lastLogin!
                      : ""))
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Chats".toUpperCase()),
      actions: [
        IconButton(
            onPressed: () {
              context
                  .read<AuthenticatedSessionCubit>()
                  .addNewFriendView();
            },
            icon: Icon(Icons.add)),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountScreen()));
            },
            icon: Icon(Icons.account_circle))
      ],
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: primaryColor,
      child: Icon(
        Icons.person_add_alt_1,
        color: Colors.white,
      ),
    );
  }

  Widget _bottomNavigation() {
    return SizedBox(
      height: 95,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger),
            label: "Wiadomosc",
          ),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage("assets/images/dog.png"),
              ),
              label: "Osoba Zaufana")
        ],
      ),
    );
  }
}
