import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:prototip_tfg/pages/DetailReservaPage.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulaInfoCardCapacitat.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulaInfoCardId.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulaInfoCardNom.dart';
import 'package:provider/provider.dart';

import '../../global.dart';

class TaulaInfoCard extends StatelessWidget {
  void _showConfirmationDialogue(BuildContext context, Taula taula) {
    final idReserva = taula.reserva.id;

    final alert = AlertDialog(
      title: Text("Eliminar Reserva:"),
      content: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Text("Seguro que deseas eliminar esta reserva ?"),
        ],
      )),
      /* Text(
          "Nom: ${reservaFinal.nom} telefon: ${reservaFinal.telefon} torn: ${reservaFinal.torn.toString()} data: ${reservaFinal.getDiaShort()} "), */
      actions: [
        FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context, true);
            }),
        FlatButton(
            child: Text("CANCEL"),
            onPressed: () {
              Navigator.pop(context, false);
            })
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((confirm) {
      if (confirm == null) return;
      if (confirm) {
        Provider.of<DiaProvider>(context, listen: false)
            .deleteReserva(idReserva);
      } else {
        return;
      }
    });
  }

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
          onLongPress: () {
            if(taula.isreserva){
              _showConfirmationDialogue(context,taula);
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
