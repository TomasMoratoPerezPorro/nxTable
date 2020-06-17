import 'package:flutter/material.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/DinarTab.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/SoparTab.dart';

class BodyTabBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        DinarTab(),
        SoparTab(),
      ],
    );
  }
}