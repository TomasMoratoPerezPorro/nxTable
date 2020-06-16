import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Reserva.dart';
import 'package:provider/provider.dart';

final Color mainColor = const Color.fromARGB(255, 44, 64, 114);
final Color bgColor = const Color.fromARGB(255, 248, 246, 242);
final Color actionColor = const Color.fromARGB(255, 255, 210, 57);
final Color disabledColor = const Color.fromARGB(50, 153, 153, 153);

final Color detailsColor = Color(0xFF3E73FA);

class DetailReservaPage extends StatelessWidget {
  const DetailReservaPage({
    Key key,
    @required this.reserva,
  }) : super(key: key);

  final Reserva reserva;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Center(
            child: Container(
                margin: EdgeInsets.only(right: 30),
                child:
                    Text("Mesa ${reserva.taula.toString()}: ${reserva.nom} "))),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          ReservaDetailsCard(),
          ComentarisReservaCard(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: actionColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.zero,
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.zero,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.call, size: 18,),
                    ),
                  ),
                  SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(reserva.telefon),
                  ),
                  SizedBox(width: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ComentarisReservaCard extends StatelessWidget {
  const ComentarisReservaCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Comentaris:  ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(reserva.comentaris != null ? reserva.comentaris : "..."),
              ],
            ),
          ),
        ),
      ),
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
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InfoReservaDetails(),
              SizedBox(height: 10),
              InfoReservaFechaHora(),
              InforReservaServicioTurno(),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class InforReservaServicioTurno extends StatelessWidget {
  const InforReservaServicioTurno({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("Servicio:  "),
                  Text(
                    reserva.servei == 1 ? "Comida" : "Cena",
                    style: TextStyle(color: Colors.black38),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text("Turno:  "),
                  Text(reserva.torn.toString(),
                      style: TextStyle(color: Colors.black38)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class InfoReservaFechaHora extends StatelessWidget {
  const InfoReservaFechaHora({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              HoraReservaWidget(),
              Text(reserva.getDia()),
            ],
          ),
          SizedBox(height: 23),
          Container(
            decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.black38, width: 1)),
            ),
          ),
        ],
      ),
    );
  }
}

class HoraReservaWidget extends StatelessWidget {
  const HoraReservaWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return Row(
      children: <Widget>[
        Icon(
          Icons.access_time,
          size: 18,
        ),
        SizedBox(width: 7),
        Text(reserva.horaEntrada.toString())
      ],
    );
  }
}

class InfoReservaDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return Container(
      decoration: BoxDecoration(
        color: reserva.getColorEstat(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  reserva.nom,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                NumeroComensalesWidget()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(
                    "Mesa ${reserva.taula.toString()}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NumeroComensalesWidget extends StatelessWidget {
  const NumeroComensalesWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reserva = Provider.of<Reserva>(context);
    return Row(
      children: <Widget>[
        Icon(
          Icons.supervisor_account,
          color: Colors.white,
          size: 25,
        ),
        SizedBox(width: 5),
        Text(
          reserva.numComensals.toString(),
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}




