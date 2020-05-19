import 'package:flutter/material.dart';
import 'package:prototip_tfg/pages/MainPage.dart';
import 'package:provider/provider.dart';

void main() => runApp(Nxtable());

class Nxtable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DiaProvider>(
        create: (context) => DiaProvider(DateTime.now()),
        child: MaterialApp(
          title: 'NxTable',
          home: DefaultTabController(length: 2, child: MainPage()),
        ));
  }
}
