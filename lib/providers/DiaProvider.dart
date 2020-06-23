import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototip_tfg/controllers/CustomApi.dart';

class DiaProvider with ChangeNotifier {
  DateTime _actualDia;
  DiaProvider(actualDia) {
    this._actualDia = actualDia;
    _getReservasDia();
  }
  bool _isLoading = false;
  dynamic _reservasDia;
  CustomApi api = CustomApi();

  DateTime get actualDia => _actualDia;
  dynamic get reservasDia => _reservasDia;
  bool get isLoading => _isLoading;

  Future<void> _getReservasDia() async {
    _isLoading = true;
    notifyListeners();
    try {
      var stats = await api.getReservasDia(_actualDia);
      _reservasDia = stats;
      debugPrint(stats.toString());
      await new Future.delayed(const Duration(seconds: 1));
      _isLoading = false;
      debugPrint(_isLoading.toString());
      notifyListeners();
    } catch (ex) {
      _reservasDia = null;
      _isLoading = false;
      notifyListeners();
      debugPrint(ex.toString());
      debugPrint("catch EXCEPTION _reservasDia = null");
    } finally {
      _isLoading = false;
      debugPrint("FINALLY");
      notifyListeners();
    }
  }

  Future<void> deleteReserva(int id)async {
    try{
      await api.deleteReserva(id);
      await new Future.delayed(const Duration(seconds: 1));
    }catch(ex){
      debugPrint(ex.toString());
    }finally{
      debugPrint("FINALLY");
      refreshDay();
    }
  }

  void changeDay(bool direction) async {
    if (direction) {
      _actualDia = _actualDia.add(Duration(hours: 24));
      //debugPrint(_actualDia.toString());
      await _getReservasDia();
      notifyListeners();
    } else {
      _actualDia = _actualDia.add(Duration(hours: -24));
      //debugPrint(_actualDia.toString());
      await _getReservasDia();
      notifyListeners();
    }
  }

  void refreshDay() async {
    await _getReservasDia();
    notifyListeners();
  }

  String getDia() {
    var dt = _actualDia;
    var newFormat = DateFormat("EEEE, dd MMMM");
    String updatedDt = newFormat.format(dt);
    return updatedDt;
  }
}
