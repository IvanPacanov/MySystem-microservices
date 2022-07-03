// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_client/blocs/addNewUser/addnewuser_bloc.dart';
// import 'package:flutter_client/blocs/addNewUser/addnewuser_state.dart';
// import 'package:flutter_client/blocs/addNewUser/addnewuser_event.dart';
// import 'package:flutter_client/models/User.dart';
// import 'package:flutter_client/repositories/component_repository.dart';
// import 'package:flutter_client/widgets/gradient_button.dart';

// class AddNewUser extends StatefulWidget {
//   final User userCred;
//   AddNewUser({required this.userCred});

//   @override
//   State<AddNewUser> createState() => _AddNewUser(userCred: userCred);
// }

// class _AddNewUser extends State<AddNewUser> {
//   final User userCred;
//   _AddNewUser({required this.userCred});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: (context) => AddNewUserBloc(
//             componetRepository: context.read<ComponentRepository>()),
//         child: BlocBuilder<AddNewUserBloc, AddnewuserState>(
//           builder: (context, state) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   searchNewUser(context),
//                   isTrustedPerson(context),
//                   trustedPerson(context),
//                   _buttonLogin(context)
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   TextFormField searchNewUser(BuildContext context) => TextFormField(
//         decoration: InputDecoration(
//             icon: Icon(Icons.security),
//             labelText: "Nazwa użytkownika"),
//         keyboardType: TextInputType.name,
//         autovalidateMode: AutovalidateMode.always,
//         onChanged: (value) => context.read<AddNewUserBloc>().add(
//               UserNameChanged(userName: value),
//             ),
//       );

//   CheckboxListTile isTrustedPerson(BuildContext context) =>
//       CheckboxListTile(
//         checkColor: Colors.white,
//         title: Text("Zaufana osoba"),
//         value: context.read<AddNewUserBloc>().isTrusted,
//         onChanged: (bool? value) {
//           setState(() {
//             context.read<AddNewUserBloc>().isTrusted = value!;
//           });
//         },
//       );

//   TextFormField addPhoneNumberUser(BuildContext context) =>
//       TextFormField(
//         maxLength: 12,
//         decoration: InputDecoration(
//             icon: Icon(Icons.security), labelText: "Numer Telefonu"),
//         keyboardType: TextInputType.phone,
//         autovalidateMode: AutovalidateMode.always,
//         onChanged: (value) => context.read<AddNewUserBloc>().add(
//               UserNameChanged(userName: value),
//             ),
//       );

//   Visibility trustedPerson(BuildContext context) => Visibility(
//         visible: context.read<AddNewUserBloc>().isTrusted,
//         child: Column(
//           children: <Widget>[addPhoneNumberUser(context)],
//         ),
//       );

//   GradientButton _buttonLogin(BuildContext context) => GradientButton(
//         width: 150,
//         height: 50,
//         onPressed: () {
//           {
//             context.read<AddNewUserBloc>().add(
//                 AddNewFriend(userUid: this.userCred.id.toString()));
//             Navigator.pop(context);
//           }
//         },
//         text: Text(
//           'LogIn',
//           style: TextStyle(color: Colors.white),
//         ),
//         icon: Icon(
//           Icons.check,
//           color: Colors.white,
//         ),
//       );
// }
