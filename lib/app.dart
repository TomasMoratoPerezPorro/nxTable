
import 'package:flutter/material.dart';
import 'package:prototip_tfg/login_flow/pages/AboutPage.dart';
import 'package:prototip_tfg/pages/MainPage.dart';
import 'package:prototip_tfg/main.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (_) => Nxtable(),
        '/about': (_) => AboutPage(),
      },
    );
  }
}
