import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:prototip_tfg/pages/DetailReservaPage.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulaInfoCardCapacitat.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulaInfoCardId.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulaInfoCardNom.dart';
import 'package:provider/provider.dart';

import '../../global.dart';

class TaulaInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taula = Provider.of<Taula>(context);
    return Container(
      width: 171,
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        child: InkWell(
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          splashColor: actionColor,
          onTap: () {
            if (taula.isreserva) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DetailReservaPage(reserva: taula.reserva)));
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TaulaInfoCardNom(),
              TaulaInfoCardCapacitat(),
              TaulaInfoCardId()
            ],
          ),
        ),
      ),
    );
  }
}