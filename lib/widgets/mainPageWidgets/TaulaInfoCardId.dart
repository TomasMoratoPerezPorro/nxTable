import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:provider/provider.dart';

class TaulaInfoCardId extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taula = Provider.of<Taula>(context);
    return Expanded(
      flex: 2,
      child: Row(
        //Rctange Inferior
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 6),
              height: 30,
              decoration: BoxDecoration(
                color: (taula.isreserva
                    ? Color.fromARGB(255, 14, 47, 65)
                    : Colors.grey),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.zero,
                    topRight: Radius.zero,
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Taula ${taula.id.toString()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}