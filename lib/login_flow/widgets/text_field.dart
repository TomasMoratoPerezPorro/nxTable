import 'package:flutter/material.dart';

enum SignInTextFieldType { email, password, userName, pis }

final Color mainColor = Color(0xFFff7f5c);
final Color secondaryColor = Color(0xFFfff7f5);

class SignInTextField extends StatefulWidget {
  final SignInTextFieldType type;
  final TextEditingController controller;
  SignInTextField(this.type, this.controller);

  @override
  _SignInTextFieldState createState() => _SignInTextFieldState();
}

class _SignInTextFieldState extends State<SignInTextField> {
  bool _viewPassword = false;

  get isPassword => widget.type == SignInTextFieldType.password;
  get isUser => widget.type == SignInTextFieldType.userName;
  get isPis => widget.type == SignInTextFieldType.pis;

  @override
  Widget build(BuildContext context) {
    Widget eye;
    if (isPassword) {
      eye = IconButton(
        icon: Icon(_viewPassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() => _viewPassword = !_viewPassword);
        },
      );
    } else if (isUser) {
      return TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 5.0),
          ),
          hintText: 'Username',
          hintStyle: TextStyle(color: Colors.grey[400]),
          suffixIcon: eye,
        ),
        keyboardType:
            isPassword ? TextInputType.text : TextInputType.emailAddress,
        obscureText: isPassword && !_viewPassword,
      );
    } else if (isPis) {
      return TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 5.0),
          ),
          hintText: 'Pis',
          hintStyle: TextStyle(color: Colors.grey[400]),
          suffixIcon: eye,
        ),
        keyboardType:
            isPassword ? TextInputType.text : TextInputType.emailAddress,
        obscureText: isPassword && !_viewPassword,
      );
    }
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(),
        hintText: isPassword ? 'Password' : 'Email',
        hintStyle: TextStyle(color: Colors.grey[400]),
        suffixIcon: eye,
      ),
      keyboardType:
          isPassword ? TextInputType.text : TextInputType.emailAddress,
      obscureText: isPassword && !_viewPassword,
    );
  }
}
