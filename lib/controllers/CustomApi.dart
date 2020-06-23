import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototip_tfg/Models/Reserva.dart';
import 'package:prototip_tfg/Models/ReservasDia.dart';
import 'package:http/http.dart' as http;
import '../global.dart';

class CustomApi {
  Future<ReservasDia> getReservasDia(DateTime data) async {
    var dt = data;
    var newFormat = DateFormat("yyyy-MM-dd");
    String updatedDt = newFormat.format(dt);

    debugPrint(UrlConstants.baseUrl + updatedDt);

    var response = await netWorkCalls.get(UrlConstants.baseUrl + updatedDt);
    var rl = await parseReservas(response.toString(),data);
    debugPrint(rl.toString());

    return rl;
  }

  Future<ReservasDia> parseReservas(String responseBody, DateTime data) async{
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    final mypased = ReservasDia.fromJson(parsed,data);
    return mypased;
  }

  Future<bool> putNewReserva(Reserva reserva) async{
    /* debugPrint("IN CUSTOM API putNewReserva: " + reserva.toString()); */
    var response = await netWorkCalls.post(UrlConstants.baseUrl,reserva);
    /* debugPrint("RESPONSE CUSTOM API putNewReserva: " + response.toString()); */
    if(response != null){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> deleteReserva(int id) async{
    var response = await netWorkCalls.delete(UrlConstants.baseUrl+id.toString());
    if(response != null){
      return true;
    }else{
      return false;
    }
  }
}
