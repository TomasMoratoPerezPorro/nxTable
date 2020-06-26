import 'package:flutter/material.dart';
import 'package:prototip_tfg/global.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                title: Text("GUARDANDO"),
                titlePadding: EdgeInsets.all(20),
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Por favor espera....",style: TextStyle(color: mainColor),)
                      ]),
                    )
                  ]));
        });
  }
}