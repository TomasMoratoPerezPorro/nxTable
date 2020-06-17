import 'package:flutter/material.dart';
import 'package:prototip_tfg/pages/MainPage.dart';
import 'package:prototip_tfg/pages/NewReservaPage.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:provider/provider.dart';


void main() => runApp(Nxtable());

/* class Nxtable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiaProvider>(
        create: (context) => DiaProvider(DateTime.now()),
        child: MaterialApp(
          title: 'NxTable',
          home: DefaultTabController(length: 2, child: MainPage()),
        ));
  }
} */

class Nxtable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<DiaProvider>(
              create: (context) => DiaProvider(DateTime.now())),
          ChangeNotifierProvider<NewReservaProvider>(
              create: (context) => NewReservaProvider()),
        ],
        child: MaterialApp(
          title: 'NxTable',
          home: DefaultTabController(length: 2, child: MainPage()),
        ));
  }
}
