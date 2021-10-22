import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/components/chat/card/chat_card.dart';
import 'package:flutter_client/components/chat/chat_bloc.dart';
import 'package:flutter_client/components/chat/chat_state.dart';
import 'package:flutter_client/components/chat/messages/message_screen.dart';
import 'package:flutter_client/components/component_cubit.dart';
import 'package:flutter_client/components/component_repository.dart';
import 'package:flutter_client/constants.dart';
import 'package:flutter_client/models/Chat.dart';
import 'package:flutter_client/models/User.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  @override
  State<ChatView> createState() => _ChatView();
}

class _ChatView extends State<ChatView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return _streamBuilder(context);
  }

  Widget _streamBuilder(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: context.read<ChatBloc>().todos,
        builder: (context, snapshot) {
          return ListView(
            children:
                snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return ListTile(
                title: Text(data['name']),
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(data['urlAvatar']),
                  backgroundColor: Colors.transparent,
                ),
              );
            }).toList(),
          );
          // switch (snapshot.connectionState) {
          //   case ConnectionState.waiting:
          //     return Center(child: CircularProgressIndicator());
          //   default:
          //     if (snapshot.hasError) {
          //       print(snapshot.error);
          //       return Text('Problems');
          //     } else {
          //       // final user = snapshot.data;
          //       return Column(
          //         children: [
          //           //   ChatHeaderWidget(null, users: user!),
          //         ],
          //       );

          //       // return Scaffold(
          //       //   body: Scaffold(
          //       //       appBar: buildAppBar(),
          //       //       body: _chatView(),
          //       //       floatingActionButton:
          //       //           _floatingActionButton(),
          //       //       bottomNavigationBar: _bottomNavigation()),
          //       // );
          //     }
          // }
        });
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search))
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

  Widget _chatView() {
    return Column(children: [
      Expanded(
          child: ListView.builder(
        itemCount: mockChatsData.length,
        itemBuilder: (context, index) => ChatCard(
          chat: mockChatsData[index],
          press: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageScreen(),
              )),
        ),
      )),
    ]);
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
              icon: Icon(Icons.messenger), label: "Wiadomosc"),
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
