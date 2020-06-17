import 'package:flutter/material.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:provider/provider.dart';

import '../../../global.dart';

class ServicioCard extends StatelessWidget {
  const ServicioCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: true);
    Color getColor(int boto) {
      int serveiActual = Provider.of<NewReservaProvider>(context).servei;
      if (serveiActual == boto) {
        return actionColor;
      } else {
        return Colors.grey[350];
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Selecciona el servicio:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    newReservaProvider.showMissingCamps &&
                            newReservaProvider.servei == null
                        ? Icon(Icons.announcement, color: Colors.red)
                        : SizedBox(width: 2),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Consumer<NewReservaProvider>(
                      builder: (context, provider, _) => RaisedButton(
                        color: getColor(1),
                        child: Text(
                          "Comida",
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Provider.of<NewReservaProvider>(context,
                                  listen: false)
                              .setServei(1);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Consumer<NewReservaProvider>(
                      builder: (context, provider, _) => RaisedButton(
                        color: getColor(2),
                        child: Text(
                          "Comida",
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Provider.of<NewReservaProvider>(context,
                                  listen: false)
                              .setServei(2);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}