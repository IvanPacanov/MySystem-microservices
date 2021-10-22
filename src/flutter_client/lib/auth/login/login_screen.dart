import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/auth/auth_cubit.dart';
import 'package:flutter_client/auth/auth_repository.dart';
import 'package:flutter_client/auth/form_submission_status.dart';
import 'package:flutter_client/auth/login/login_block.dart';
import 'package:flutter_client/auth/login/login_event.dart';
import 'package:flutter_client/auth/login/login_state.dart';
import 'package:flutter_client/widgets/gradient_button.dart';
import 'package:permission_handler/permission_handler.dart';


class LoginScreen extends StatelessWidget {
  final _formKey2 = GlobalKey<FormState>();


@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepository: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _loginForm(context),
            _showSignUpButton(context),
          ],
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
            autovalidateMode: AutovalidateMode.always,
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
            autovalidateMode: AutovalidateMode.always,
            validator: (value) => state.isValidUserName
                ? null
                : 'UserName is too short',
            onChanged: (value) => context
                .read<LoginBloc>()
                .add(LoginUsernameChanged(userName: value)));
      },
    );
  }

  Widget _buttonLogin(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : GradientButton(
              width: 150,
              height: 50,
              onPressed: () {
                if (_formKey2.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
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
    });
  }

  Widget _buttonRegister(BuildContext context) {
    return GradientButton(
      width: 150,
      height: 50,
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text('Camera Permission'),
                  content: Text(
                      'This app needs camera access to take pictures for upload user profile photo'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Deny'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoDialogAction(
                      child: Text('Settings'),
                      onPressed: () => openAppSettings(),
                    ),
                  ],
                ));
      },
      text: Text(
        'Register',
        style: TextStyle(color: Colors.white),
      ),
      icon: Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
    );
  }

  Widget _sizeBoxH10() {
    return SizedBox(
      height: 10,
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
              _sizeBoxH10(),
              _buttonLogin(context),
              _sizeBoxH10(),
              _buttonRegister(context),
              _sizeBoxH10(),
              _showGuestUpButton(context),
            ],
          ),
        ),
      ),
    );
  }

  

  Widget _showSignUpButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
      child: Text('Don\'t have an account? Sign up.'),
      onPressed: () => context.read<AuthCubit>().showSignUp(),
    ));
  }

  Widget _showGuestUpButton(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
      return TextButton(
        child: Text('Guest?.'),
        onPressed: () =>
            context.read<LoginBloc>().add(LoginAsGuest()),
            
      );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
