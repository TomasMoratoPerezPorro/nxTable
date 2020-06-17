import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/IndicadorEstat.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulaInfoCard.dart';
import 'package:provider/provider.dart';

class TaulaStack extends StatelessWidget {
  const TaulaStack({
    Key key,
    @required this.taula,
  }) : super(key: key);

  final Taula taula;

  @override
  Widget build(BuildContext context) {
    return Provider<Taula>.value(
      value: taula,
      child: Stack(children: <Widget>[
        IndicadorEstat(),
        TaulaInfoCard(),
      ]),
    );
  }
}