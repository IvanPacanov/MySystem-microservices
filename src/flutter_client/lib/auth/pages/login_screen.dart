import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_cubit.dart';
import 'package:flutter_client/auth/blocs/login/login_block.dart';
import 'package:flutter_client/auth/blocs/login/login_event.dart';
import 'package:flutter_client/auth/blocs/login/login_state.dart';
import 'package:flutter_client/auth/form_submission_status.dart';
import 'package:flutter_client/auth/services/auth_services.dart';

class LoginScreen extends StatelessWidget {
  final _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (context) => LoginBloc(
            authRepository: context.read<AuthServices>(),
            authCubit: context.read<AuthCubit>(),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _loginForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _emailField(),
              _passwordField(),
              _sizeBoxH10(value: 50),
              _loginButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: "Password",
            ),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => state.isValidPassword
                ? null
                : 'Password is too short',
            onChanged: (value) => context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password: value)));
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFormField(
            decoration: InputDecoration(
                icon: Icon(Icons.email), labelText: "Email"),
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) => state.isValidUserName
                ? null
                : 'UserName is too short',
            onChanged: (value) => context
                .read<LoginBloc>()
                .add(LoginUsernameChanged(userName: value)));
      },
    );
  }

  Widget _loginButton(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : InkWell(
              onTap: () {
                if (_formKey2.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.orange.shade400, width: 5),
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
    });
  }

  Widget _sizeBoxH10({double value = 10}) {
    return SizedBox(
      height: value,
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
