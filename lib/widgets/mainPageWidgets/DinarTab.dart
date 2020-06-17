import 'package:flutter/material.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';
import 'package:prototip_tfg/providers/ServeiProvider.dart';
import 'package:prototip_tfg/widgets/mainPageWidgets/TaulesGrid.dart';
import 'package:provider/provider.dart';

class DinarTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<DiaProvider>(context, listen: true).isLoading) {
      return Center(
          child: CircularProgressIndicator(
        strokeWidth: 4,
      ));
    } else {
      return ChangeNotifierProxyProvider<DiaProvider, ServeiProvider>(
          create: (_) => ServeiProvider(1, 1),
          update: (_, diaProvider, serveiProvider) =>
              serveiProvider..update(diaProvider),
          child: TaulesGrid(
            servei: 1,
          ));
    }
  }
}