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
        title: Center(child: Container(margin: EdgeInsets.only(right: 30),child: Text("Mesa ${reserva.taula.toString()}: ${reserva.nom} "))),
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
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              BarraEstatDetails(),
              InfoReservaDetails(),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoReservaDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          DetailsNameMesa(),
          DetailsIcons(),
          DetailsServeiTorn(),
          DetailsComentaris(),
        ],
      ),
    );
  }
}

class DetailsComentaris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 60),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Comentaris:  ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text("${reserva.comentaris}"),
        ],
      ),
    );
  }
}

class DetailsServeiTorn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Servei:  ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(reserva.serveiToString()),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 7),
          child: Row(
            children: <Widget>[
              Text(
                "Torn:  ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(reserva.torn.toString()),
            ],
          ),
        ),
      ],
    );
  }
}

class DetailsIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(right: 7),
                    child: Icon(
                      Icons.event,
                      size: 20,
                    )),
                Text(reserva.getDia()),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 7),
                      child: Icon(
                        Icons.access_time,
                        size: 20,
                      )),
                  Text(reserva.horaEntrada.toString()),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 30),
          child: Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(right: 7),
                  child: Icon(
                    Icons.phone,
                    size: 20,
                  )),
              Text(reserva.telefon.toString()),
            ],
          ),
        ),
      ],
    );
  }
}

class DetailsNameMesa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          reserva.nom,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text("Mesa ${reserva.taula.toString()}"),
        ),
      ],
    );
  }
}

class BarraEstatDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return Column(
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
    );
  }
}
