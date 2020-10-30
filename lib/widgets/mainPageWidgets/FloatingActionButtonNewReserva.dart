import 'package:flutter/material.dart';
import 'package:prototip_tfg/pages/NewReservaPage.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:provider/provider.dart';

import '../../global.dart';

class FloatingActionButtonNewReserva extends StatelessWidget {
  const FloatingActionButtonNewReserva({
    Key key,
    @required this.newReservaProvider,
  }) : super(key: key);

  final NewReservaProvider newReservaProvider;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      foregroundColor: Colors.black,
      backgroundColor: actionColor,
      child: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return NewReservasPage();
            },
          ),
        ).then((result) {
          if (newReservaProvider.reservaConfirmada) {
            Provider.of<DiaProvider>(context, listen: false).refreshDay();
          }
          newReservaProvider.resetData();
        });
      },
    );
  }
}
