import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/blocs/addNewUser/addnewuser_bloc.dart';
import 'package:flutter_client/auth/blocs/addNewUser/addnewuser_state.dart';
import 'package:flutter_client/auth/blocs/addNewUser/addnewuser_event.dart';
import 'package:flutter_client/widgets/gradient_button.dart';

class AddNewUser extends StatefulWidget {
  @override
  State<AddNewUser> createState() => _AddNewUser();
}

class _AddNewUser extends State<AddNewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddnewuserBloc, AddnewuserState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                searchNewUser(context),
                isTrustedPerson(context),
                trustedPerson(context),
                _buttonLogin()
              ],
            ),
          );
        },
      ),
    );
  }

  TextFormField searchNewUser(BuildContext context) => TextFormField(
        decoration: InputDecoration(
            icon: Icon(Icons.security),
            labelText: "Nazwa użytkownika"),
        keyboardType: TextInputType.name,
        autovalidateMode: AutovalidateMode.always,
        onChanged: (value) => context.read<AddnewuserBloc>().add(
              UserNameChanged(userName: value),
            ),
      );

  CheckboxListTile isTrustedPerson(BuildContext context) =>
      CheckboxListTile(
        checkColor: Colors.white,
        title: Text("Zaufana osoba"),
        value: context.read<AddnewuserBloc>().isTrusted,
        onChanged: (bool? value) {
          setState(() {
            context.read<AddnewuserBloc>().isTrusted = value!;
          });
        },
      );

  TextFormField addPhoneNumberUser(BuildContext context) =>
      TextFormField(
        maxLength: 12,
        decoration: InputDecoration(
            icon: Icon(Icons.security), labelText: "Numer Telefonu"),
        keyboardType: TextInputType.phone,
        autovalidateMode: AutovalidateMode.always,
        onChanged: (value) => context.read<AddnewuserBloc>().add(
              UserNameChanged(userName: value),
            ),
      );

  Visibility trustedPerson(BuildContext context) => Visibility(
        visible: context.read<AddnewuserBloc>().isTrusted,
        child: Column(
          children: <Widget>[addPhoneNumberUser(context)],
        ),
      );

  GradientButton _buttonLogin() => GradientButton(
        width: 150,
        height: 50,
        onPressed: () {
          {
            context.read<AddnewuserBloc>().add(AddNewFriend());
            Navigator.pop(context);
          }
        },
        text: Text(
          'LogIn',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
}
