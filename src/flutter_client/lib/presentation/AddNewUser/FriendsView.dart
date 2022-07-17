import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/blocs/addNewUser/addnewuser_bloc.dart';
import 'package:flutter_client/blocs/addNewUser/addnewuser_event.dart';
import 'package:flutter_client/blocs/addNewUser/addnewuser_state.dart';
import 'package:flutter_client/session/chatSession/authenticated_session_cubit.dart';
import 'package:provider/provider.dart';

class FriendsView extends StatefulWidget {
  const FriendsView({Key? key}) : super(key: key);

  @override
  State<FriendsView> createState() => _FriendsView();
}

class _FriendsView extends State<FriendsView> {
  final _formKey2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewUserBloc(
          authRepository:
              context.read<AuthenticatedSessionCubit>().authServices),
      child: BlocBuilder<AddNewUserBloc, AddNewUserState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
                padding: EdgeInsets.only(left: 50, right: 50),
                alignment: Alignment.center,
                height: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Form(
                        key: _formKey2,
                        child: TextFormField(
                          decoration: InputDecoration(
                              icon: Icon(Icons.person_add),
                              labelText: "User email"),
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          onChanged: (value) => context
                              .read<AddNewUserBloc>()
                              .add(UserNameChanged(userName: value)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _cardElement(_addFriend(context)),
                    ])),
          );
        },
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

  Widget _addFriend(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_formKey2.currentState!.validate()) {
          context.read<AddNewUserBloc>().add(AddNewFriendSubmitted());
        }
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
            Text('Add Friend'.toUpperCase()),
          ],
        ),
      ),
    );
  }
}
