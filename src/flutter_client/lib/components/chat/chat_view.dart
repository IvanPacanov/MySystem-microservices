import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/components/chat/card/chat_card.dart';
import 'package:flutter_client/components/chat/chat_bloc.dart';
import 'package:flutter_client/components/chat/chat_state.dart';
import 'package:flutter_client/components/chat/messages/message_screen.dart';
import 'package:flutter_client/components/chat/widget/chat_header.dart';
import 'package:flutter_client/components/component_repository.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/Chat.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/presentation/AddNewUser.dart';
import 'package:flutter_client/presentation/VideoCall.dart';
import 'package:flutter_client/presentation/VideoCall2.dart';
import 'package:flutter_client/session/session_state.dart';
import 'package:flutter_client/widgets/gradient_button.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  @override
  State<ChatView> createState() => _ChatView();
}

class _ChatView extends State<ChatView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: _bottomNavigation(),
      body: Column(children: <Widget>[
        ChatHeaderWidget(),
        Flexible(
          child: BlocProvider(
            create: (context) => ChatBloc(
                componehtRepository:
                    context.read<ComponentRepository>(),
                authRepository: context.read<AuthRepository>()),
            child: Scaffold(
              body: _connectionString(),
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

  Widget _buttton2() {
    return BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
      return GradientButton(
        width: 150,
        height: 50,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoCall(),
              ));
        },
        text: Text(
          'VideoScreen',
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
      return StreamBuilder<QuerySnapshot>(
          stream: context
              .read<ChatBloc>()
              .componehtRepository
              .getListOfFriends,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState ==
                    ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    final Friends us = Friends.fromJson(data);
                    return ListTile(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessageScreen(
                                friend: us,
                              ),
                            ))
                      },
                      title: Text(us.name!),
                      leading: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(us.urlAvatar!),
                        backgroundColor: Colors.transparent,
                      ),
                    );
                  }).toList(),
                );
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          });
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNewUser()));
            },
            icon: Icon(Icons.add))
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
