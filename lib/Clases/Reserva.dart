import 'package:prototip_tfg/Clases/Restaurant.dart';

//ESTAT 1= Tronja; 2= Blau; 3= Verd; 4=Vermell

class Reserva {
  int id;
  int servei;
  int torn;
  String nom;
  String telefon;
  int taula;
  String comentaris;
  Hora horaEntrada;
  int estat;

  Reserva(this.id, this.servei, this.torn, this.nom, this.telefon, this.taula,
      this.comentaris, this.horaEntrada, this.estat);
}

