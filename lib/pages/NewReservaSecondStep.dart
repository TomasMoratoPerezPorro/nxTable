import 'package:flutter/material.dart';
import 'package:prototip_tfg/pages/NewReservaPage.dart';
import 'package:prototip_tfg/pages/MainPage.dart';
import 'package:provider/provider.dart';

final Color mainColor = const Color.fromARGB(255, 44, 64, 114);
final Color bgColor = const Color.fromARGB(255, 248, 246, 242);
final Color actionColor = const Color.fromARGB(255, 255, 210, 57);
final Color disabledColor = const Color.fromARGB(50, 153, 153, 153);

class NewReservaSecondStep extends StatelessWidget {
  const NewReservaSecondStep({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopInfoBar(text: "Selecciona una mesa disponible:");
  }

  /* Column(
        children: <Widget>[
          TopInfoBar(text: "Selecciona una mesa disponible:"),
          InfoPreviewCard(),
          SeleccioDeTaules(),
        ],
      ); */
}

class SeleccioDeTaules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<DiaProvider, ServeiProvider>(
        create: (_) => ServeiProvider(1, 1),
        update: (_, diaProvider, serveiProvider) =>
            serveiProvider..update(diaProvider),
        child: TaulesGrid(
          servei: 1,
        ));
  }
}

class InfoPreviewCard extends StatelessWidget {
  const InfoPreviewCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      newReservaProvider.getDia(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 30),
                    NumeroComensalesWidget(),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  newReservaProvider.servei == 1 ? "COMIDA" : "CENA",
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
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
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: true);
    return Row(
      children: <Widget>[
        Icon(
          Icons.supervisor_account,
          color: Colors.black,
          size: 25,
        ),
        SizedBox(width: 5),
        Text(
          newReservaProvider.numComensales.toString(),
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
