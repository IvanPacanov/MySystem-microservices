import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_cubit.dart';
import 'package:flutter_client/auth/confirm/confirmation_view.dart';
import 'package:flutter_client/auth/sign_up/sign_up_view.dart';
import 'package:flutter_client/auth/login/login_screen.dart';
import 'package:flutter_client/components/chat/chat_view.dart';
import 'package:flutter_client/components/component_cubit.dart';
import 'package:flutter_client/components/main/main_view.dart';

class ComponentNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComponentCubit, ComponnetState>(
        builder: (context, state) {
      return Navigator(
        pages: [
          if (state == ComponnetState.main)
            MaterialPage(child: MainView())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
