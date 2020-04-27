import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Reserva.dart';
import 'package:provider/provider.dart';

final Color mainColor = const Color.fromARGB(255, 44, 64, 114);
final Color bgColor = const Color.fromARGB(255, 248, 246, 242);
final Color actionColor = const Color.fromARGB(255, 255, 210, 57);
final Color disabledColor = const Color.fromARGB(50, 153, 153, 153);

class DetailReservaPage extends StatelessWidget {
  const DetailReservaPage({
    Key key,
    @required this.reserva,
  }) : super(key: key);

  final Reserva reserva;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('NxTable')),
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            DetailsWidget(reserva: reserva),
          ],
        ),
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    @required this.reserva,
  });

  final Reserva reserva;
  @override
  Widget build(BuildContext context) {
    return Provider<Reserva>.value(
      value: reserva,
      child: ReservaDetailsCard(),
    );
  }
}

class ReservaDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      width: 20,
                      decoration: BoxDecoration(
                        color: reserva.getColorEstat(),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.zero,
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.zero,
                        ),
                      ),
                    ))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(reserva.nom),
                Text(reserva.taula.toString()),
                Text(reserva.telefon),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
