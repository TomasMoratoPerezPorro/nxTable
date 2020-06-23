import 'package:flutter/material.dart';

final Color secondaryColor = Color(0xFFfff7f5);

class SignInButton extends StatelessWidget {
  
  final String text;
  final Color color;
  final Function onPressed;
  SignInButton({
    this.text = "Sign In",
    this.color = Colors.blue,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      color: color,
      disabledColor: Colors.grey[400],
      padding: EdgeInsets.all(16),
    );
  }
}
