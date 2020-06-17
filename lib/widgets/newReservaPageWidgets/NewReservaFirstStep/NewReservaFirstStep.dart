import 'package:flutter/material.dart';
import 'package:prototip_tfg/widgets/newReservaPageWidgets/NewReservaFirstStep/CalendarCard.dart';
import 'package:prototip_tfg/widgets/newReservaPageWidgets/NewReservaFirstStep/ComensalesCard.dart';
import 'package:prototip_tfg/widgets/newReservaPageWidgets/NewReservaFirstStep/ServicioCard.dart';

import '../TopInfoBar.dart';

class NewReservaFirstStep extends StatelessWidget {
  const NewReservaFirstStep({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TopInfoBar(text: "Selecciona una fecha y servicio disponibles:"),
          ComensalesCard(),
          ServicioCard(),
          CalendarCard(),
        ],
      ),
    );
  }
}