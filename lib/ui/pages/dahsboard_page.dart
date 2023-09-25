import 'package:flutter/material.dart';
import 'package:testing_api/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsPage extends StatefulWidget {
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final OrderService orderService = OrderService(); // Inisialisasi OrderService

  @override
  void initState() {
    super.initState();
    _fetchOrderDetails();
  }

  Future<void> _fetchOrderDetails() async {
    try {
      final String orderNumber = 'KOM23091178316541'; // Gantilah dengan nomor pesanan yang sesuai
      final Map<String, dynamic> orderData = await orderService.getOrderDetails(orderNumber);
      
      // Di sini, Anda bisa melakukan pemeriksaan terhadap data yang diterima dari API
      // Contoh: Cek apakah orderData sesuai dengan format yang diharapkan

      print('Data Pesanan: $orderData');
    } catch (error) {
      print('Terjadi kesalahan saat mengambil data pesanan: $error');
    }
  }

void _logout() async {
  final prefs = await SharedPreferences.getInstance();

  // Hapus token dari SharedPreferences
  await prefs.remove('token');
  print('Token dihapus.');

  // Gunakan Future.delayed untuk menunda navigasi ke halaman login selama beberapa milidetik
  Future.delayed(Duration(milliseconds: 500), () {
    Navigator.pushReplacementNamed(context, '/login');
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Detail Pesanan'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _logout(); // Panggil metode logout saat tombol logout ditekan
            },
          ),
        ],
      ),
      body: Center(
        child: CircularProgressIndicator(), // Tampilkan indikator loading selama pengambilan data
      ),
    );
  }
}
