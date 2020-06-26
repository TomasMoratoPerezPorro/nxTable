import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:prototip_tfg/Models/Reserva.dart';

import '../global.dart';
import 'package:http/http.dart';

class NetworkCalls {
  Future<String> get(String url) async {
    var response = await client.get(url).timeout(Duration(seconds: 10));
    checkAndThrowError(response);
    return response.body;
  }

  Future<String> post(String url, Reserva item) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };
    final parsed = item.toJson();
    var bodydata = json.encode(parsed);

    debugPrint("JSON BEFORE SEND:  " + bodydata.toString());
    debugPrint("URL BEFORE SEND:  " + url);

    var response =
        await client.post(url, body: bodydata, headers: requestHeaders);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<String> delete(String url) async {
    debugPrint("URL BEFORE SEND:  " + url);

    var response = await client.delete(url);
    checkAndThrowError(response);
    return response.body;
  }

  static void checkAndThrowError(Response response) {
    if (response.statusCode != HttpStatus.ok) throw Exception(response.body);
  }
}
