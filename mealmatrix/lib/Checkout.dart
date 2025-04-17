// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, camel_case_types

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import 'package:mealmatrix/main.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Checkout());
  }
}

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

List<Map<String, dynamic>> checkoutdata = [];

class _CheckoutState extends State<Checkout> {
  Future<void> rendercheckout() async {
    try {
      var url = Uri.parse("http://192.168.177.67/Firebase/cartrendering.php");

      var response = await http.post(url, body: {'email': Logdata.userEmail});

      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);
        checkoutdata =
            (decoded as List)
                .map(
                  (record) => {
                    'name': record['name'],
                    'supply': record['supply'],
                    'qty': record['qty'],
                    'canteen': record['canteen'],
                    'price': double.parse(record['price'].toString()),
                    'image': record['image'],
                  },
                )
                .toList();
        setState(() {});
      } else {
        log("Failed to fetch data: ${response.statusCode}");
      }
    } catch (ex) {
      log("Unexpected error: $ex");
    }
  }

  @override
  void initState() {
    super.initState();
    rendercheckout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Checkout'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                'lib/assets/images/Meal Matrix Logo.png',
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ...checkoutdata.map(
              (item) => OrderItem(
                imageUrl: item['image'],
                canteen: item['canteen'],
                name: item['name'],
                qty: item['qty'].toString(),
                price: item['price'],
              ),
            ),
            SizedBox(height: 16),
            SummarySection(),
            SizedBox(height: 16),
            PaymentMethodSection(),
            Spacer(),
            PlaceOrderButton(),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String imageUrl;
  final String canteen;
  final String name;
  final String qty;
  final double price;

  OrderItem({
    required this.imageUrl,
    required this.canteen,
    required this.name,
    required this.qty,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.network(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(canteen, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Rs. ${price.toStringAsFixed(2)}'),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        qty,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(name),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class calculate {
  static double caltotal() {
    return checkoutdata.fold(
      0,
      (sum, item) => sum + (item['price'] * item['qty']),
    );
  }

  static double calitems() {
    return checkoutdata.fold(0, (sum, item) => sum + item['qty']);
  }
}

class SummarySection extends StatelessWidget {
  final total = calculate.caltotal();
  final items = calculate.calitems();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Items'), Text('${items.toInt()}')],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Rs. ${total.toInt()}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PaymentMethodSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment method', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          children: [
            Checkbox(value: false, onChanged: (value) {}),
            Text('Cash'),
          ],
        ),
        Row(
          children: [
            Checkbox(value: false, onChanged: (value) {}),
            Text('Credit or Debit card'),
          ],
        ),
      ],
    );
  }
}

class PlaceOrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // You can define place order logic here
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Place Order',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
