import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Network/NetworkCalls.dart';

final Color mainColor = const Color.fromARGB(255, 44, 64, 114);
final Color bgColor = const Color.fromARGB(255, 248, 246, 242);
final Color actionColor = const Color.fromARGB(255, 255, 210, 57);
final Color disabledColor = const Color.fromARGB(50, 153, 153, 153);


final client = Client();

final netWorkCalls = NetworkCalls();


abstract class UrlConstants {
  static const String baseUrl = 'http://10.0.2.2:3000/reservas/';
}