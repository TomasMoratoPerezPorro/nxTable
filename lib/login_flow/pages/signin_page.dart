

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototip_tfg/Models/DatabaseService.dart';
import 'package:prototip_tfg/login_flow/auth_state_switch.dart';

import 'package:prototip_tfg/login_flow/pages/signup_page.dart';
import 'package:prototip_tfg/login_flow/widgets/auth_page_title.dart';
import 'package:prototip_tfg/login_flow/widgets/button_sign_in.dart';
import 'package:prototip_tfg/login_flow/widgets/button_sign_in_with.dart';
import 'package:prototip_tfg/login_flow/widgets/or_bar.dart';
import 'package:prototip_tfg/login_flow/widgets/text_field.dart';

import 'package:provider/provider.dart';

final Color mainColor = Color(0xFFff7f5c);
final Color secondaryColor = Color(0xFFfff7f5);

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _SignInPageBody(),
      backgroundColor: secondaryColor,
    );
  }
}

class _SignInPageBody extends StatefulWidget {
  @override
  _SignInPageBodyState createState() => _SignInPageBodyState();
}

class _SignInPageBodyState extends State<_SignInPageBody> {
  bool _dead = false;
  bool _showLoading = false;
  TextEditingController _ctrlEmail, _ctrlPassword;
  bool signButtonActive = false;

  @override
  void initState() {
    super.initState();
    _ctrlEmail = TextEditingController();
    _ctrlPassword = TextEditingController();
    _ctrlEmail.addListener(_updateSignButtonActive);
    _ctrlPassword.addListener(_updateSignButtonActive);
  }

  void _updateSignButtonActive() {
    setState(() {
      signButtonActive =
          (_ctrlEmail.text.isNotEmpty && _ctrlPassword.text.isNotEmpty);
    });
  }

  void _showSnackbar(String message,
      {IconData icon, Color color = Colors.red}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Row(
        children: <Widget>[
          if (icon != null) ...[Icon(icon), SizedBox(width: 10)],
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: color,
    ));
  }

  void _showError(PlatformException e) {
    switch (e.code) {
      case 'ERROR_TOO_MANY_REQUESTS':
        _showSnackbar(
          "Too many unsuccessful login attempts, try again later.",
          icon: Icons.warning,
        );
        break;
      case 'ERROR_WRONG_PASSWORD':
      case 'ERROR_USER_NOT_FOUND':
        _showSnackbar("Wrong user and password combination");
        break;
      case 'ERROR_INVALID_EMAIL':
        _showSnackbar("Invalid email");
        break;
      case 'ERROR_WEAK_PASSWORD':
        _showSnackbar(
            "The password is too weak (should be at least 6 characters)");
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        _showSnackbar("The provided email is already signed up");
        break;
      default:
        print(e.toString());
        _showSnackbar("Unknown error '${e.code}'");
    }
  }

  @override
  void dispose() {
    _dead = true;
    super.dispose();
  }

  void showLoading(bool b) {
    if (!_dead) {
      setState(() => _showLoading = b);
    }
  }

  void _signInAnonymously() async {
    try {
      showLoading(true);
      await FirebaseAuth.instance.signInAnonymously();
    } catch (e) {
      _showError(e);
    } finally {
      showLoading(false);
    }
  }

  void _signInWithEmailAndPassword() async {
    try {
      showLoading(true);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _ctrlEmail.text,
        password: _ctrlPassword.text,
      );
    } catch (e) {
      _showError(e);
    } finally {
      showLoading(false);
    }
  }

  void _createUserWithEmailAndPassword(EmailAndPassword credentials) async {
    try {
      showLoading(true);
      AuthResult result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: credentials.email,
        password: credentials.password,
      );
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(credentials.getterUserName);
    } on PlatformException catch (e) {
      _showError(e);
    } finally {
      showLoading(false);
    }
  }
      
        @override
        Widget build(BuildContext context) {
          if (_showLoading) {
            return Center(child: CircularProgressIndicator());
          }
          final SignInConfig config = Provider.of<SignInConfig>(context);
        //  final primaryColor = Theme.of(context).primaryColor;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 120),
                    AuthPageTitle('Sign In'),
                    SizedBox(height: 24),
                    SignInTextField(SignInTextFieldType.email, _ctrlEmail),
                    SizedBox(height: 16),
                    SignInTextField(SignInTextFieldType.password, _ctrlPassword),
                    SizedBox(height: 32),
                    
                    SignInButton(
                      color: mainColor,
                      onPressed:
                          signButtonActive ? _signInWithEmailAndPassword : null,
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Need an account?',
                          style: TextStyle(
                            color: Colors.black45,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        SizedBox(width: 16),
                        FlatButton(
                          child: Text('Sign Up'),
                          textColor: mainColor,
                          onPressed: () async {
                            EmailAndPassword result =
                                await Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => SignUpPage()),
                            );
                            if (result != null) {
                              _createUserWithEmailAndPassword(result);
                            }
                          },
                        ),
                      ],
                    ),
                    if (config.withFacebook || config.withGoogle) ...[
                      OrBar(spaceTop: 12, spaceBottom: 24),
                      Row(
                        children: <Widget>[
                          if (config.withGoogle)
                            Expanded(
                              child: SignInWithButton(
                                'Google',
                                FontAwesomeIcons.google,
                              ),
                            ),
                          if (config.withFacebook && config.withGoogle)
                            SizedBox(width: 16),
                          if (config.withFacebook)
                            Expanded(
                              child: SignInWithButton(
                                'Facebook',
                                FontAwesomeIcons.facebook,
                              ),
                            ),
                        ],
                      ),
                    ],
                    if (config.anonymously) ...[
                      Spacer(),
                      FlatButton(
                        child: Text(
                          'Sign in anonymously',
                          style: TextStyle(color: mainColor),
                        ),
                        onPressed: _signInAnonymously,
                      ),
                      SizedBox(height: 20),
                    ]
                  ],
                ),
              ),
            ),
          );
        }
      }
      
     
