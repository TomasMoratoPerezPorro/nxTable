
import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:provider/provider.dart';

class TaulaInfoCardCapacitat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taula = Provider.of<Taula>(context);
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.only(top: 5, right: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              taula.maxpersonas.toString() + ' ',
              style: TextStyle(fontSize: 10),
            ),
            Icon(
              Icons.people,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}