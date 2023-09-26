import 'package:flutter/material.dart';
import 'package:testing_api/services/order_service.dart'; // Impor OrderService atau sesuaikan dengan struktur proyek Anda.

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _orderNumberController = TextEditingController();
  final OrderService _orderService = OrderService();
  String _result = '';

  Future<void> _fetchOrderDetails() async {
    final orderNumber = _orderNumberController.text.trim();
    try {
      final orderData = await _orderService.getOrderDetails(orderNumber);
      setState(() {
        _result = 'Data Pemesanan: $orderData';
      });
    } catch (e) {
      setState(() {
        _result = 'Terjadi kesalahan: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Cek API'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _orderNumberController,
              decoration: InputDecoration(labelText: 'Nomor Pesanan'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchOrderDetails,
              child: Text('Cari'),
            ),
            SizedBox(height: 16),
            Text(
              _result,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
