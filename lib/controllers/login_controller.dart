import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testing_api/models/response_model.dart';
import 'package:testing_api/services/login_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class LoginController {
  LoginRepository _repository = LoginRepository();

  bool isLoading = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<MyResponse> login() async {
    http.Response result =
        await _repository.login(emailController.text, passwordController.text);

    print("cek ${result.body}");

    if (result.statusCode == 200) {
      print('Berhasil login');
      Map<String, dynamic> myBody = jsonDecode(result.body);

      // Simpan token dari respons
      String? token = myBody['token'];

      if (token != null) {
        final prefs = await SharedPreferences.getInstance();

        // Simpan data token ke SharedPreferences
        await prefs.setString('token', token);
        print('Token telah disimpan: $token');

        // Load token dari SharedPreferences
        String? savedToken = prefs.getString('token');
        if (savedToken != null) {
          // Token berhasil dimuat, Anda dapat menggunakannya
          print('Token: $savedToken');
        } else {
          // Token tidak ditemukan di SharedPreferences
          print('Token tidak ditemukan');
        }
      } else {
        // Handle jika token tidak ditemukan dalam respons
        print('Token tidak ditemukan dalam respons');
      }

      // Kemudian Anda dapat mengembalikan respons yang telah dimodifikasi
      return MyResponse(status: 200, message: "Login berhasil", data: myBody);
    } else {
      return MyResponse(status: 1, message: "Terjadi kesalahan. Coba lagi");
    }
  }
}
