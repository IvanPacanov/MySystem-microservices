import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_client/app_navigator.dart';
import 'package:flutter_client/auth/services/auth_services.dart';
import 'package:flutter_client/auth/pages/login_screen.dart';
import 'package:flutter_client/session/session_cubit.dart';
import 'package:flutter_client/session/session_state.dart';
import 'package:settings_ui/settings_ui.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    return BlocProvider(
      create: (context) =>
          SessionCubit(authServices: context.read<AuthServices>()),
      child: BlocBuilder<SessionCubit, SessionState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Profil"),
            ),
            body: SettingsList(
              sections: [
                // SettingsSection(
                //   titlePadding: EdgeInsets.all(20),
                //   title: 'Section 1',
                //   tiles: [
                //     SettingsTile(
                //       title: 'Language',
                //       subtitle: 'English',
                //       leading: Icon(Icons.language),
                //       onPressed: (BuildContext context) {},
                //     ),
                //     SettingsTile.switchTile(
                //       title: 'Use System Theme',
                //       leading: Icon(Icons.phone_android),
                //       switchValue: isSwitched,
                //       onToggle: (value) {
                //         setState(() {
                //           isSwitched = value;
                //         });
                //       },
                //     ),
                //   ],
                // ),
                SettingsSection(
                  
                  titlePadding: EdgeInsets.all(20),
                  tiles: [
                    // SettingsTile(
                    //   title: 'Security',
                    //   subtitle: 'Fingerprint',
                    //   leading: Icon(Icons.lock),
                    //   onPressed: (BuildContext context) {},
                    // ),
                    SettingsTile(
                      title: 'Wyloguj',
                      leading: Icon(Icons.logout),
                      onPressed: (BuildContext context) {
                        //context.read<SessionCubit>().signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AppNavigator()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
