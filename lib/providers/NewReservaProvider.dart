import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewReservaProvider with ChangeNotifier {
  DateTime _actualDia;
  int _numComensales;
  int _idServicio = 0;
  String _nom;
  String _telefon;
  int _idTorn;
  int _estat;
  int _idTaula;

  int get servei => _idServicio;

  void _setServei(int idServei) {
    this._idServicio = idServei;
    notifyListeners();
  }

  String getDia() {
    var dt = _actualDia;
    var newFormat = DateFormat("EEEE, dd MMMM");
    String updatedDt = newFormat.format(dt);
    return updatedDt;
  }
}