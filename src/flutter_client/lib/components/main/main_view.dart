import 'package:flutter/material.dart';
import 'package:flutter_client/components/chat/chat_view.dart';
import 'package:flutter_client/constants.dart';

class MainView extends StatefulWidget {
  @override
  State<MainView> createState() => _MainView();
}

class _MainView extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: _buildAppBar(),
  //     body: ChatView(),
  //     floatingActionButton: _floatingActionButton(),
  //     bottomNavigationBar: _bottomNavigation(),
  //   );
  // }

  // AppBar _buildAppBar() {
  //   return AppBar(
  //     automaticallyImplyLeading: false,
  //     title: Text("Chats"),
  //     actions: [
  //       IconButton(onPressed: () {}, icon: Icon(Icons.search))
  //     ],
  //   );
  // }

  // SizedBox _bottomNavigation() {
  //   return SizedBox(
  //     height: 95,
  //     child: BottomNavigationBar(
  //       type: BottomNavigationBarType.fixed,
  //       currentIndex: _selectedIndex,
  //       onTap: (value) {
  //         setState(() {
  //           _selectedIndex = value;
  //         });
  //       },
  //       items: [
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.messenger), label: "Wiadomosc"),
  //         BottomNavigationBarItem(
  //             icon: CircleAvatar(
  //               radius: 14,
  //               backgroundImage: AssetImage("assets/images/dog.png"),
  //             ),
  //             label: "Osoba Zaufana")
  //       ],
  //     ),
  //   );
  // }

  // FloatingActionButton _floatingActionButton() {
  //   return FloatingActionButton(
  //     onPressed: () {},
  //     backgroundColor: primaryColor,
  //     child: Icon(
  //       Icons.person_add_alt_1,
  //       color: Colors.white,
  //     ),
  //   );
  // }
}
