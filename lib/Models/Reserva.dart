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
  String horaEntrada;
  int estat;
  int numComensals;
  List<int> taules;

  Reserva(
      {this.id,
      this.servei,
      this.torn,
      this.nom,
      this.telefon,
      this.taula,
      this.comentaris,
      this.horaEntrada,
      this.dia,
      this.estat,
      this.numComensals});

  Reserva.multiple(
      {this.id,
      this.servei,
      this.torn,
      this.nom,
      this.telefon,
      this.comentaris,
      this.horaEntrada,
      this.dia,
      this.estat,
      this.numComensals,
      this.taules});

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      id: json['id_reserva'] as int,
      servei: json['id_servei'] as int,
      torn: json['id_torn'] as int,
      nom: json['nom'] as String,
      telefon: json['telefon'] as String,
      taula: json['id_taula'] as int,
      comentaris: json['comentaris'] as String,
      dia: DateTime.parse(json['data']) as DateTime,
      horaEntrada: json['hora_entrada'] as String,
      estat: json['estat'] as int,
      numComensals: json['num_comensals'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nom'] = this.nom;
    data['telefon'] = this.telefon;
    data['torn'] = this.torn;
    data['data'] = getDiaShort();
    data['num_comensals'] = this.numComensals;
    data['estat'] = this.estat;
    data['comentaris'] = this.comentaris;
    data['id_taula'] = this.taules;
    return data;
  }

  String getDia() {
    var dt = this.dia;
    var newFormat = DateFormat("EEEE, dd MMMM","es_ES");
    String updatedDt = newFormat.format(dt);
    return updatedDt;
  }

  String getDiaShort() {
    var dt = this.dia;
    var newFormat = DateFormat("yyyy-MM-dd","es_ES");
    String updatedDt = newFormat.format(dt);
    return updatedDt;
  }

  String serveiToString() {
    if (this.servei == 1) {
      return "Comida";
    }
    if (this.servei == 2) {
      return "Cena";
    } else {
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
