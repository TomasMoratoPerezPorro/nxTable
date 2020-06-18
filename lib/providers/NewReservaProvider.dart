import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewReservaProvider with ChangeNotifier {
  DateTime _actualDia = DateTime.now();
  int _numComensales;
  int _idServicio;
  String _nom;
  String _telefon;
  int _idTorn;
  int _estat;
  int _idTaula;
  bool showMissingCamps = false;

  int get servei => _idServicio;
  int get numComensales => _numComensales;
  DateTime get actualDia => _actualDia;

  void setDia(DateTime dia) {
    this._actualDia = dia;

    notifyListeners();
  }

  void setServei(int idServei) {
    this._idServicio = idServei;
    notifyListeners();
  }

  String getDia() {
    var dt = _actualDia;
    var newFormat = DateFormat("EEEE, dd MMMM");
    String updatedDt = newFormat.format(dt);
    return updatedDt;
  }

  void setNumComensales(int i) {
    this._numComensales = i;
    notifyListeners();
  }

  bool canProceed(int index) {
    if (index == 0) {
      if (_numComensales != null && _idServicio != null && _actualDia != null) {
        return true;
      } else {
        showMissingCamps = true;
        notifyListeners();
        return false;
      }
    }
  }

  void resetData(){
    _actualDia = DateTime.now();
    this._numComensales = null;
    this._idServicio = null;
    this.showMissingCamps = false;
  }
}