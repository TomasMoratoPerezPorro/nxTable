import 'package:flutter/material.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:prototip_tfg/widgets/newReservaPageWidgets/NewReservaFirstStep/ComensalesButton.dart';
import 'package:provider/provider.dart';

class ComensalesCard extends StatelessWidget {
  const ComensalesCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newReservaProvider =
        Provider.of<NewReservaProvider>(context, listen: true);
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
                      "Selecciona el nº de comensales:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    newReservaProvider.showMissingCamps &&
                            newReservaProvider.numComensales == null
                        ? Icon(Icons.announcement, color: Colors.red)
                        : SizedBox(width: 2),
                  ],
                ),
                SizedBox(height: 15),
                Row(children: <Widget>[
                  for (var i = 1; i < 8; i++) ComensalesButton(id: i),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}