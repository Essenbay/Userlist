import 'dart:async';
import 'package:http/http.dart' as http;

class UserApi {
  static Future getUsers() {
    return http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
  }
}