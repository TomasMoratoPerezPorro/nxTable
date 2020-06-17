import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Reserva.dart';
import 'package:prototip_tfg/Models/Restaurant.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';

final List<TaulaFisica> taulesFisiquesProva = [
  TaulaFisica(1, 2),
  TaulaFisica(2, 2),
  TaulaFisica(3, 2),
  TaulaFisica(4, 2),
  TaulaFisica(5, 2),
  TaulaFisica(6, 2),
  TaulaFisica(7, 2),
  TaulaFisica(8, 2),
  TaulaFisica(9, 2),
  TaulaFisica(10, 2),
  TaulaFisica(11, 2),
  TaulaFisica(12, 4),
  TaulaFisica(13, 4),
  TaulaFisica(14, 4),
  TaulaFisica(15, 4),
  TaulaFisica(16, 4),
];

class ServeiProvider with ChangeNotifier {
  TaulesList _taules;
  int _actualTorn;
  int _actualServei;
  DateTime _actualDia = DateTime.now();
  List<Reserva> _reservas = [];

  ServeiProvider(this._actualServei, this._actualTorn);

  void update(DiaProvider diaProvider) async {
    // Do some custom work based on myModel that may call `notifyListeners`
    _actualDia = diaProvider.actualDia;

    if (diaProvider.reservasDia.reservas != null) {
      _reservas = diaProvider.reservasDia.reservas;
      await setTaulesList();
      notifyListeners();
    }
  }

  TaulesList get taules => _taules;
  int get torn {
    if (_actualServei == 1) {
      return _actualTorn;
    } else {
      return _actualTorn - 1;
    }
  }

  int get servei => _actualServei;

  setTaulesList() async {
    if (_actualServei == 1) {
      var llistataules = await TaulesList.getLlistaTaules(_actualDia,
          _actualServei, _actualTorn, taulesFisiquesProva, _reservas);
      _taules = llistataules;
      //_actualTorn = 1;

      notifyListeners();
    } else if (_actualServei == 2) {
      var llistataules = await TaulesList.getLlistaTaules(_actualDia,
          _actualServei, _actualTorn, taulesFisiquesProva, _reservas);
      _taules = llistataules;
      //_actualTorn = 1;

      notifyListeners();
    }
  }

  changeTaulesList(int torn) async {
    if (_actualServei == 2) {
      var llistataules = await TaulesList.getLlistaTaules(
          _actualDia, _actualServei, torn + 1, taulesFisiquesProva, _reservas);
      _taules = llistataules;
      _actualTorn = torn + 1;

      notifyListeners();
    } else {
      var llistataules = await TaulesList.getLlistaTaules(
          _actualDia, _actualServei, torn, taulesFisiquesProva, _reservas);
      _taules = llistataules;
      _actualTorn = torn;

      notifyListeners();
    }
  }
}