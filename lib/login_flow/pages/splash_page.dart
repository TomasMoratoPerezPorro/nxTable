import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  final String error;
  const SplashPage({this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/splashscreen.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: error != null ? Text(error) : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
