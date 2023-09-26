import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderService {
  final String baseUrl = 'https://dev.komship.komerce.my.id/api/v2/admin/order';

  Future<Map<String, dynamic>> getOrderDetails(String orderNumber) async {
    final bearerToken =
        'GATEWAYKOMSHIPKOMERCE'; // Ganti dengan token bearer yang sesuai.
    final response = await http.get(
      Uri.parse('$baseUrl/search?search=$orderNumber'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer $bearerToken', // Sesuaikan format header otorisasi.
      },
    );

    if (response.statusCode == 200) {
      print(
          'URL yang digunakan: ${Uri.parse('$baseUrl/search?search=$orderNumber')}');
      print('cek token : $bearerToken');
      return jsonDecode(response.body);
    } else {
      // Menggunakan pesan kesalahan dari respons HTTP jika tersedia
      final errorMessage = jsonDecode(response.body)['message'] ??
          'Gagal mengambil detail pesanan';
      throw Exception(errorMessage);
    }
  }
}
