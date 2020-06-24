import 'package:flutter/material.dart';
import 'package:prototip_tfg/login_flow/widgets/auth_page_title.dart';
import 'package:prototip_tfg/login_flow/widgets/button_sign_in.dart';
import 'package:prototip_tfg/login_flow/widgets/text_field.dart';

import '../../global.dart';

class EmailAndPassword {
  final String email, password, userName;
  EmailAndPassword(this.email, this.password, this.userName);

  String get getterUserName {
    return this.userName;
  }

  toString() => "Email: '$email' / Password: '$password'";
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/signupscreen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 180),
                
                SizedBox(height: 24),
                SignInTextField(SignInTextFieldType.email, _email),
                SizedBox(height: 24),
                SignInTextField(SignInTextFieldType.userName, _userName),
                SizedBox(height: 24),
                SizedBox(height: 24),
                SignInTextField(SignInTextFieldType.password, _password),
                SizedBox(height: 48),
                SignInButton(
                  color: mainColor,
                  text: 'Sign Up',
                  onPressed: () {
                    Navigator.of(context).pop(
                      EmailAndPassword(
                          _email.text, _password.text, _userName.text),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
