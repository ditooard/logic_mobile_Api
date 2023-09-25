import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class OrderService {
  final String baseUrl = 'http://dev.komship.komerce.my.id/api/v2/admin/order';

  Future<Map<String, dynamic>> getOrderDetails(String orderNumber) async {
    final response = await http.get(
      Uri.parse(
          'http://dev.komship.komerce.my.id/api/v2/admin/order/search?search=KOM23091178316541'),
      // Send authorization headers to the backend.
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'GATEWAYKOMSHIPKOMERCE'
      },
    );
    final responseJson = jsonDecode(response.body);

    print('cekkkk ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Gagal mengambil detail pesanan');
    }
  }
}
