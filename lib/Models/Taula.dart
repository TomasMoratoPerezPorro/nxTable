import 'package:prototip_tfg/Models/Reserva.dart';
import 'package:prototip_tfg/Models/ReservasDia.dart';
import 'package:prototip_tfg/Models/Restaurant.dart';

class Taula {
  int id;
  int maxpersonas;
  bool isreserva;
  Reserva reserva;
  bool isSelected = false;

  Taula(this.id, this.maxpersonas, this.isreserva, this.reserva);

  
}

class TaulesList {
  List<Taula> taulesInfoList = [];

  TaulesList(this.taulesInfoList);
  TaulesList.empty() {
    taulesInfoList = [];
  }

  Taula getTaula(int index) => taulesInfoList[index];
  List<Taula> getTaules() => taulesInfoList;

  static Future<TaulesList> getLlistaTaules(DateTime dia, int servei, int torn,
      List<TaulaFisica> taulesFisiques, List<Reserva> reservas) async {
    var reservesDelDia = reservas;
    List<Taula> returnListTaules = [];
    Taula taulaf;

    for (var taulafisica in taulesFisiques) {
      bool isfree = true;
      //print(taulafisica.id);
      for (var reserva in reservesDelDia) {
        //print(reserva.nom);
        if (reserva.taula == taulafisica.id) {
          if (reserva.servei == servei) {
            if (reserva.torn == torn) {
              taulaf =
                  Taula(taulafisica.id, taulafisica.maxPersonas, true, reserva);
              //print('Taula: ${taulaf.id} - Reserva: ${taulaf.reserva}');
              returnListTaules.add(taulaf);
              isfree = false;
            }
          }
        }
      }
      if (isfree) {
        taulaf = Taula(taulafisica.id, taulafisica.maxPersonas, false, null);
        returnListTaules.add(taulaf);
      }
    }

    var returnObject = TaulesList(returnListTaules);

    return returnObject;
  }
}
