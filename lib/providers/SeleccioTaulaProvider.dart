import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Reserva.dart';
import 'package:prototip_tfg/Models/ReservasDia.dart';
import 'package:prototip_tfg/Models/Restaurant.dart';
import 'package:prototip_tfg/Models/Taula.dart';
import 'package:prototip_tfg/controllers/CustomApi.dart';
import 'package:prototip_tfg/providers/DiaProvider.dart';
import 'package:prototip_tfg/providers/NewReservaProvider.dart';

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

class SeleccioTaulaProvider with ChangeNotifier {
  TaulesList _taules;
  int _actualTorn = 1;
  int _actualServei = 1;
  DateTime _actualDia = DateTime.now();
  ReservasDia _reservasDia;
  
  CustomApi api = CustomApi();


  

  DateTime get actualDia => _actualDia;
  dynamic get reservasDia => _reservasDia;
  int get actualTorn => _actualTorn;

  void update(NewReservaProvider newReservaProviderProvider)  {
    if(_actualDia != newReservaProviderProvider.actualDia || _actualServei !=newReservaProviderProvider.servei){
      _actualDia = newReservaProviderProvider.actualDia;
    _actualServei = newReservaProviderProvider.servei;
    
    if(_actualServei == 2){
      _actualTorn = 2;
    }else{
      _actualTorn = 1;
    }
    _taules=null;
    getReservasDia();
     notifyListeners(); 
    }
    
  }

  Future<ReservasDia> getReservasDia() async {
    try {
      var stats = await api.getReservasDia(_actualDia);
      _reservasDia = stats;
       await new Future.delayed(const Duration(seconds: 1)); 
      /* notifyListeners(); */
      
      return _reservasDia;
    } catch (ex) {
      debugPrint("DEBUG 1 ERROR: " + ex.toString());
      return null;
      
    } finally {
      /* notifyListeners(); */
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
      var llistataules = await TaulesList.getLlistaTaules(
          _actualDia,
          _actualServei,
          _actualTorn,
          taulesFisiquesProva,
          _reservasDia.reservas);
      _taules = llistataules;
      notifyListeners();

      //_actualTorn = 1;

    } else if (_actualServei == 2) {
      var llistataules = await TaulesList.getLlistaTaules(
          _actualDia,
          _actualServei,
          _actualTorn,
          taulesFisiquesProva,
          _reservasDia.reservas);
      _taules = llistataules;
      notifyListeners();
    }
  }

  changeTaulesList(int torn) async {
    if (_actualServei == 2) {
      var llistataules = await TaulesList.getLlistaTaules(_actualDia,
          _actualServei, torn + 1, taulesFisiquesProva, _reservasDia.reservas);
      _taules = llistataules;
      _actualTorn = torn + 1;

      notifyListeners();
    } else {
      var llistataules = await TaulesList.getLlistaTaules(_actualDia,
          _actualServei, torn, taulesFisiquesProva, _reservasDia.reservas);
      _taules = llistataules;
      _actualTorn = torn;

      notifyListeners();
    }
  }
}
