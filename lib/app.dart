import 'package:flutter/material.dart';
import 'package:prototip_tfg/login_flow/pages/AboutPage.dart';
import 'package:prototip_tfg/pages/MainPage.dart';
import 'package:prototip_tfg/main.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
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
      ),
    );
  }
}
