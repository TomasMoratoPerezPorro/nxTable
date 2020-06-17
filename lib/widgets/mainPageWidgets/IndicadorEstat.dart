import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:provider/provider.dart';

class IndicadorEstat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taula = Provider.of<Taula>(context);
    return Container(
      //indicador estat
      margin: EdgeInsets.only(left: 27, top: 2),
      width: 35,
      height: 40,
      decoration: BoxDecoration(
          color: (taula.isreserva
              ? taula.reserva.getColorEstat()
              : Color.fromARGB(0, 250, 62, 87)),
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }
}