import 'package:flutter/material.dart';
import 'package:testing_api/services/order_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _orderNumberController = TextEditingController();
  final OrderService orderService = OrderService();

  // Tambahkan fungsi untuk logout
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
        title: Text('Cari Pesanan'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Icon logout
            onPressed: _logout, // Panggil fungsi logout saat tombol ditekan
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _orderNumberController,
              decoration: InputDecoration(labelText: 'Nomor Pesanan'),
            ),
            ElevatedButton(
              onPressed: () {
                final orderNumber = _orderNumberController.text;
                _searchOrder(orderNumber);
              },
              child: Text('Cari'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _searchOrder(String orderNumber) async {
    try {
      final Map<String, dynamic> orderData =
          await orderService.getOrderDetails(orderNumber);

      // Navigasi ke halaman hasil pencarian atau tampilkan hasil pencarian sesuai kebutuhan Anda.
      // Contoh:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultPage(orderData: orderData),
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Terjadi Kesalahan'),
            content: Text('Gagal mencari pesanan: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tutup'),
              ),
            ],
          );
        },
      );
    }
  }
}

class SearchResultPage extends StatelessWidget {
  final Map<String, dynamic> orderData;

  SearchResultPage({required this.orderData});

  @override
  Widget build(BuildContext context) {
    // Tampilkan hasil pencarian sesuai kebutuhan.
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil Pencarian'),
      ),
      body: Center(
        child: Text('Nomor Pesanan: ${orderData['orderNumber']}'),
      ),
    );
  }
}
