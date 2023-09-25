import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginRepository {
  Future<http.Response> login(String email, String password) {
    return http.post(Uri.parse("http://192.168.1.8:9000/login"),
        headers: <String, String>{
          'Content-Type': "application/json; charset=UTF-8"
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));
  }
}
