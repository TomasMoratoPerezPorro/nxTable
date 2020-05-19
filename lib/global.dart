import 'package:http/http.dart';

import 'Network/NetworkCalls.dart';


final client = Client();

final netWorkCalls = NetworkCalls();


abstract class UrlConstants {
  static const String baseUrl = 'http://10.0.2.2:3000/';
}