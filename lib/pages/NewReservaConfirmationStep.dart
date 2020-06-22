import 'package:flutter/material.dart';
import 'package:prototip_tfg/pages/DetailReservaPage.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:prototip_tfg/providers/SeleccioTaulaProvider.dart';
import 'package:prototip_tfg/widgets/newReservaPageWidgets/TopInfoBar.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class NewReservaConfirmationStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: true);
    final int torn =
        Provider.of<SeleccioTaulaProvider>(context, listen: false).torn;
    final reserva = newReservaProvider.createReservaObject(torn);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TopInfoBar(text: "Confirma la información: "),
          newReservaProvider.reservaConfirmada
              ? ReservaConfirmadaWidget()
              : DetailsWidget(reserva: reserva),
        ],
      ),
    );
  }
}

class ReservaConfirmadaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: Provider.of<NewReservaProvider>(context, listen: true)
            .saveReserva(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text(
                  'Fetch chuck joke.',
                  textAlign: TextAlign.center,
                ),
              );
            case ConnectionState.active:
              return Center(child: CircularProgressIndicator(strokeWidth: 4));
            case ConnectionState.waiting:
              return Center(
                  child: Container(
                      child: CircularProgressIndicator(strokeWidth: 4)));
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text("Error creating reserva"));
              } else {
                return Center(child: Text("No error"));
              }
          }
          return CircularProgressIndicator(strokeWidth: 4);
        });
  }
}
