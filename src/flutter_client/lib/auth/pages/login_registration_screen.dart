import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_cubit.dart';
import 'package:flutter_client/auth/blocs/login/login_block.dart';

import '../services/auth_services.dart';

class LoginRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => LoginBloc(
        authRepository: context.read<AuthServices>(),
        authCubit: context.read<AuthCubit>(),
      ),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _registrationButton(context),
            SizedBox(
              height: 50,
            ),
            _loginButton(context),
          ],
        ),
      ),
    ));
  }

  Widget _registrationButton(BuildContext context) {
    return InkWell(
      onTap: () => context.read<AuthCubit>().openRegistrationPage(),
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
            Icon(Icons.app_registration,
                size: 50, color: Colors.orange.shade400),
            Text('Zarejestruj się'),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return InkWell(
      onTap: () => context.read<AuthCubit>().openLoginPage(),
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
            Icon(Icons.login,
                size: 50, color: Colors.orange.shade400),
            Text('Zaloguj się'),
          ],
        ),
      ),
    );
  }
}
