import 'package:flutter/material.dart';
import 'package:prototip_tfg/pages/MainPage.dart';

void main() => runApp(Nxtable());

class Nxtable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NxTable',
      home: DefaultTabController(length: 2, child: MainPage()),
    );
  }
}
