import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/models/User.dart';
import 'package:flutter_client/models/UserFriend.dart';
import 'package:flutter_client/presentation/Guardian/bloc/guardian_bloc.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'package:intl/intl.dart';

class GuardianView extends StatefulWidget {
  final User user;
  const GuardianView({Key? key, required this.user})
      : super(key: key);

  @override
  State<GuardianView> createState() => _GuardianViewState(user);
}

class _GuardianViewState extends State<GuardianView> {
  final User user;

  _GuardianViewState(this.user);

  @override
  Widget build(BuildContext context) {
    var guardian = user.isGuardian
        ? user.friends
            .where((element) => element.guardianEmail == user.email)
            .first
        : user.guardianEmail;

    guardian != null ? print('dupa') : print('Walę');

    return BlocBuilder<GuardianBloc, GuardianState>(
      builder: (context, state) {
        context.read<GuardianBloc>().friend =
            guardian != null ? guardian as UserFriend : null;
        return Scaffold(
          bottomNavigationBar: _bottomNavigation(),
          body: Container(
              child: guardian == null
                  ? _noGuardianAssigned()
                  : guardian is UserFriend
                      ? _assignedToSave(guardian)
                      : _guardianAssigned(guardian as String)),
        );
      },
    );
  }

  Widget _noGuardianAssigned() {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nie została ustawiona osoba zaufana'),
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: "Wprowadź adres email osoby",
              ),
              obscureText: true,
            )
          ]),
    );
  }

  Widget _assignedToSave(UserFriend user) {
    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.green),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(user.urlAvatar!),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      (user.nick as String).toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Ostatnia aktywność:",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(DateFormat('hh:mm dd-MM-yyyy')
                          .format(DateTime.parse(
                              user.lastLogin as String))
                          .toString()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.green.shade300,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("Sprawdź status"),
                ),
                FloatingActionButton.large(
                  backgroundColor: Colors.orange.shade300,
                  onPressed: () {
                    context
                        .read<GuardianBloc>()
                        .add(CheckStatusEvent());
                  },
                  child: const Icon(Icons.star_outline_sharp),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.blue.shade300,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Przypomnienie",
                    ),
                  ),
                ),
                FloatingActionButton.large(
                  backgroundColor: Colors.orange.shade300,
                  onPressed: () {
                    context.read<GuardianBloc>().add(ReminderEvent(
                        message: 'aaaaa',
                        targetConnectionId: user.connectionId!));
                  },
                  child: const Icon(Icons.alarm),
                ),
              ],
            ),
          ),
        ),
        Card(
          color: Colors.red.shade300,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("Połaczenie alarmowe z osobą"),
                ),
                FloatingActionButton.large(
                  backgroundColor: Colors.orange.shade300,
                  onPressed: null,
                  child: const Icon(Icons.phone),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _guardianAssigned(String email) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            // CircleAvatar(
            //   radius: 60.0,
            //   backgroundImage: NetworkImage(friend!.urlAvatar!),
            //   backgroundColor: Colors.transparent,
            // ),
            // Text(friend!.nick as String),
          ],
        ),
      ],
    );
  }

  Widget _bottomNavigation() {
    return Container(
        height: 95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red.shade200,
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                    color: Colors.black,
                    iconSize: 75,
                    onPressed: () {
                      // context.read<ChatBloc>().onUpdatedFriendIsSet =
                      //     false;
                      // context.read<ChatBloc>().onUpdatedFriend =
                      //     () {};
                      context
                          .read<AuthenticatedSessionCubit>()
                          .lastState();
                    },
                    icon: Icon(Icons.arrow_back_rounded)),
              ),
            ),
          ],
        ));
  }
}
