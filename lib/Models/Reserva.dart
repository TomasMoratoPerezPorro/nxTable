import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototip_tfg/Models/Restaurant.dart';

//ESTAT 1= Tronja; 2= Blau; 3= Verd; 4=Vermell

class Reserva {
  int id;
  int servei;
  int torn;
  String nom;
  String telefon;
  int taula;
  String comentaris;
  DateTime dia;
  Hora horaEntrada;
  int estat;

  Reserva(this.id, this.servei, this.torn, this.nom, this.telefon, this.taula,
      this.comentaris, this.horaEntrada, this.dia, this.estat);

  String getDia() {
    var dt = this.dia;
    var newFormat = DateFormat("EEEE, dd MMMM");
    String updatedDt = newFormat.format(dt);
    return updatedDt;
  }

  String serveiToString(){
    if(this.servei==1){
      return "Comida";
    }if(this.servei==2){
      return "Cena";
    }else{
      return "Error";
    }
  }

  

  Color getColorEstat() {
    switch (this.estat) {
      case 1:
        return Color.fromARGB(255, 255, 118, 0);
        break;
      case 2:
        return Color.fromARGB(255, 62, 115, 250);
        break;
      case 3:
        return Color.fromARGB(255, 62, 250, 131);
        break;
      case 4:
        return Color.fromARGB(255, 44, 64, 114);
        break;
      default:
        return Color.fromARGB(0, 250, 62, 87);
        break;
    }
  }
}
