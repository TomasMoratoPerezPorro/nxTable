
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototip_tfg/login_flow/pages/splash_page.dart';
import 'package:prototip_tfg/login_flow/signin_flow_app.dart';

import 'package:provider/provider.dart';

class SignInConfig {
  final bool anonymously;
  final bool withGoogle;
  final bool withFacebook;
  const SignInConfig({
    this.anonymously = false,
    this.withGoogle = false,
    this.withFacebook = false,
  });
}

class AuthStateSwitch extends StatelessWidget {
  final config;
  final Widget app;
  AuthStateSwitch({
    @required this.app,
    this.config = const SignInConfig(),
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasError) {
          return SplashPage(error: snapshot.error.toString());
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return SplashPage(error: "ConnectionState is none!");

          case ConnectionState.waiting:
            return SplashPage();

          case ConnectionState.active:
            {
              final FirebaseUser user = snapshot.data;
              return user == null
                  ? Provider<SignInConfig>.value(
                      value: config,
                      child: SignInFlowApp(),
                    )
                  : Provider<FirebaseUser>.value(
                      value: user,
                      child: this.app,
                    );
            }

          case ConnectionState.done:
          default:
            return SplashPage(error: "ConnectionState is done!");
        }
      },
    );
  }
}
