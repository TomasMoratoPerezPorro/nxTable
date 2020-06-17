import 'package:flutter/material.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:provider/provider.dart';

import '../../../global.dart';

class ComensalesButton extends StatelessWidget {
  const ComensalesButton({
    Key key,
    @required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    Color getColor(int boto) {
      int numComensalesActual =
          Provider.of<NewReservaProvider>(context).numComensales;
      if (numComensalesActual == boto) {
        return actionColor;
      } else {
        return Colors.grey[350];
      }
    }

    return ButtonTheme(
      minWidth: 10,
      height: 30,
      child: RaisedButton(
        onPressed: () {
          Provider.of<NewReservaProvider>(context, listen: false)
              .setNumComensales(id);
        },
        child: Text(
          id.toString(),
          style: TextStyle(fontSize: 12),
        ),
        color: getColor(id),
      ),
    );
  }
}