import 'package:flutter/material.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'dart:async';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';
import 'package:flutter_client/presentation/Chat/chat_view.dart';
import 'package:flutter_client/session/session_cubit.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  static const MethodChannel _channel =
      const MethodChannel('flashlight');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            _cardElement(_latarkaButton(context)),
            _cardElement(_phoneButton(context)),
            _cardElement(_guardianButton(context)),
            _cardElement(_chatButton(context)),
            _cardElement(_logoutButton(context)),
          ],
        ),
      ),
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

  Widget _logoutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SessionCubit>().logout();
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
            Text('Chat'.toUpperCase()),
          ],
        ),
      ),
    );
  }

  Widget _phoneButton(BuildContext context) {
    return InkWell(
      onTap: () {},
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
            Icon(Icons.call, size: 50, color: Colors.orange.shade400),
            Text('Telefon'.toUpperCase()),
          ],
        ),
      ),
    );
  }

  Widget _guardianButton(BuildContext context) {
    return InkWell(
      onTap: () {},
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

  Widget _latarkaButton(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {});
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
            Icon(Icons.flashlight_on,
                size: 50, color: Colors.orange.shade400),
            Text('Latarka'.toUpperCase()),
          ],
        ),
      ),
    );
  }

  Widget _sizeBoxH10({double value = 10}) {
    return SizedBox(
      height: value,
    );
  }
}
