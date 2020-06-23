import 'package:flutter/material.dart';
final Color mainColor = Color(0xFFff7f5c);
final Color secondaryColor = Color(0xFFfff7f5);

class AuthPageTitle extends StatelessWidget {
  final String text;
  AuthPageTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        this.text,
        style: TextStyle(
          fontSize: 40,
          color: mainColor,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
