import 'package:flutter/material.dart';
import 'package:prototip_tfg/app.dart';
import 'package:prototip_tfg/login_flow/auth_state_switch.dart';

/* void main() => runApp(Nxtable()); */

void main() {
  runApp(
    AuthStateSwitch(
      app: App(),
      config: SignInConfig(
        anonymously: false,
        withGoogle: false,
        withFacebook: false,
      ),
    ),
  );
}
