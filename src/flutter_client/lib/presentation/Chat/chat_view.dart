import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/blocs/chat/chat_bloc.dart';
import 'package:flutter_client/blocs/chat/chat_state.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/AddNewUser/AddNewUser.dart';
import 'package:flutter_client/presentation/Chat/messages/message_screen.dart';
import 'package:flutter_client/presentation/Chat/widget/chat_header.dart';
import 'package:flutter_client/presentation/VideoCall.dart';
import 'package:flutter_client/presentation/account/account_screen.dart';
import 'package:flutter_client/repositories/component_repository.dart';
import 'package:flutter_client/services/SignalR_Servis.dart';
import 'package:flutter_client/session/chatSession/chatSession_cubit.dart';
import 'package:flutter_client/widgets/gradient_button.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
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
            create: (context) => SignalRProvider(
                chatSessionCubit:
                    context.read<AuthenticatedSessionCubit>()),
            child: BlocProvider(
              create: (context) => ChatBloc(
                  componehtRepository:
                      context.read<ComponentRepository>(),
                  authRepository: context.read<AuthRepository>(),
                  chatSessionCubit:
                      context.read<AuthenticatedSessionCubit>(),
                  signalR: context.read<SignalRProvider>()),
              child: Scaffold(
                body: _connectionString(),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buttton() {
    return BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
      return GradientButton(
        width: 150,
        height: 50,
        onPressed: () {
          context.read<ChatBloc>().sendCos();
        },
        text: Text(
          'Send Message',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
    });
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

  Widget _connectionString() {
    return BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
      // if (true) {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => VideoCall2(
      //             friend: friend,
      //             peerConnection: _peerConnection,
      //             remoteRenderer: _remoteRenderer),
      //       ));
      // }
      userCred = context.read<ChatBloc>().authRepository.userNew;

      return ListView.builder(
          itemCount: userCred.friends.length,
          itemBuilder: (context, index) {
            return _friendCard(userCred.friends[index]);

            // return ListTile(
            //   onTap: () => {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => MessageScreen(
            //             friend: userCred.friends[index],
            //           ),
            //         ))
            //   },
            //   title: Text(userCred.friends[index].nick!),
            //   leading: CircleAvatar(
            //     radius: 60.0,
            //     backgroundImage:
            //         NetworkImage(userCred.friends[index].urlAvatar!),
            //     backgroundColor: Colors.transparent,
            //   ),
            // );
          });
    });
  }

  Widget _friendCard(UserFriend friend) {
    return Card(
      color: friend.isOnline! ? Colors.green.shade200 : Colors.white,
      child: IntrinsicHeight(
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MessageScreen(
                    friend: friend,
                  ),
                ));
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
                    Text(friend.nick!,
                        style: TextStyle(fontSize: 20)),
                    Text(
                        friend.chats!.length > 0
                            ? (friend.chats![0].messages!.length > 0
                                ? friend.chats![0].messages![0].text!
                                : "")
                            : "",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: friend.chats!.length > 0
                              ? (friend.chats![0].messages!.length > 0
                                  ? friend.chats![0].messages![0]
                                          .read!
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddNewUser(userCred: userCred)));
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

  // Widget _chatView() {
  //   return Column(children: [
  //     Expanded(
  //         child: ListView.builder(
  //       itemCount: mockChatsData.length,
  //       itemBuilder: (context, index) => ChatCard(
  //         chat: mockChatsData[index],
  //         press: () => Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => MessageScreen(),
  //             )),
  //       ),
  //     )),
  //   ]);
  // }

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
