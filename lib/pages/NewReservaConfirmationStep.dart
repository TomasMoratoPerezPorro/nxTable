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
          DetailsWidget(reserva: reserva),
        ],
      ),
    );
  }
}
