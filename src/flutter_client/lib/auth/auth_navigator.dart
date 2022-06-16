import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_cubit.dart';
import 'package:flutter_client/auth/pages/confirmation_Screen.dart';
import 'package:flutter_client/auth/pages/sign_up_Screen.dart';
import 'package:flutter_client/auth/pages/login_Screen.dart';
import 'package:flutter_client/session/session_cubit.dart';

class AuthNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(sessionCubit: context.read<SessionCubit>()),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return _navi(state);
        },
      ),
    );
  }
}

Widget _navi(AuthState state) {
  return Navigator(
    pages: [
      if (state == AuthState.login) ...[
        MaterialPage(child: LoginScreen())
      ],
      if (state == AuthState.signUp ||
          state == AuthState.confirmSignUp) ...[
        MaterialPage(child: SignUpView()),
        if (state == AuthState.confirmSignUp)
          MaterialPage(child: ConfirmationView())
      ],
    ],
    onPopPage: (route, result) => route.didPop(result),
  );
}
