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
      bottomNavigationBar: _bottomNavigation(),
      body: Container(
        child: Column(children: <Widget>[
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
                body: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/background-image.jpg"), //photo by Photo by ????
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: _connectionString(context)),
              ),
            ),
          ),
        ]),
      ),
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

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 75,
      backgroundColor: Colors.green,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: IconButton(
                iconSize: 40,
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
