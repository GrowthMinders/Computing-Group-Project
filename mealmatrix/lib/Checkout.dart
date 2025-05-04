// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, camel_case_types, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealmatrix/Cart.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:mealmatrix/main.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const Checkout(),
    );
  }
}

class Checkout extends StatefulWidget {
  const Checkout();

  @override
  _CheckoutState createState() => _CheckoutState();
}

List<Map<String, dynamic>> checkoutdata = [];

class _CheckoutState extends State<Checkout> {
  Future<void> rendercheckout() async {
    try {
      var url = Uri.parse("http://192.168.8.101/Firebase/cartrendering.php");

      var response = await http.post(url, body: {'email': Logdata.userEmail});

      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);
        checkoutdata = (decoded as List)
            .map(
              (record) => {
                'id': record['id'],
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
        backgroundColor: Colors.teal,
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('lib/assets/images/Meal Matrix Logo.png'),
              radius: 20,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE082), Color(0xFFFFB300)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    kToolbarHeight -
                    MediaQuery.of(context).padding.top,
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Order Summary',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ...checkoutdata.map(
                    (item) => OrderItem(
                      imageUrl: item['image'],
                      supply: item['supply'],
                      name: item['name'],
                      qty: item['qty'].toString(),
                      price: item['price'],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SummarySection(),
                  const SizedBox(height: 24),
                  PaymentMethodSection(),
                  const SizedBox(height: 24),
                  PlaceOrderButton(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String imageUrl;
  final String supply;
  final String name;
  final String qty;
  final double price;

  OrderItem({
    required this.imageUrl,
    required this.supply,
    required this.name,
    required this.qty,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      color: Colors.white.withOpacity(0.9),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    supply,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  Text(
                    'Rs. ${price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            qty,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          name,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class calculate {
  static double caltotal() {
    return checkoutdata.fold(
      0.0,
      (sum, item) => sum + (item['price'] * (item['qty'] as num).toDouble()),
    );
  }

  static double calitems() {
    return checkoutdata.fold(
      0.0,
      (sum, item) => sum + (item['qty'] as num).toDouble(),
    );
  }
}

class SummarySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final total = calculate.caltotal();
    final items = calculate.calitems();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Items',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${items.toInt()}',
                  style: const TextStyle(fontSize: 16, color: Colors.teal),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Rs. ${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodSection extends StatefulWidget {
  @override
  _PaymentMethodSectionState createState() => _PaymentMethodSectionState();
}

String selectedMethod = 'None';

class _PaymentMethodSectionState extends State<PaymentMethodSection> {
  bool cardSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Checkbox(
              value: cardSelected,
              onChanged: (value) {
                setState(() {
                  cardSelected = value!;
                  selectedMethod =
                      cardSelected ? 'Credit or Debit card' : 'None';
                });
                log('Selected: $selectedMethod');
              },
              activeColor: Colors.teal,
              checkColor: Colors.white,
            ),
            Text(
              'Credit or Debit card',
              style: TextStyle(
                fontSize: 16,
                color: cardSelected ? Colors.teal : Colors.grey[600],
                fontWeight: cardSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PlaceOrderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final total = calculate.caltotal();

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          List<String> proceedNames =
              checkoutdata.map((item) => item["name"] as String).toList();

          List<String> proceedSupply =
              checkoutdata.map((item) => item["supply"] as String).toList();

          List<int> proceedQty =
              checkoutdata.map((item) => item["qty"] as int).toList();

          final String totalValue = total.toStringAsFixed(2);
          final String url = "http://192.168.8.101/Firebase/paymentgateway.php?"
              "amount=${totalValue.toString()}"
              "&email=${Uri.encodeComponent(Logdata.userEmail)}"
              "&names=${Uri.encodeComponent(json.encode(proceedNames))}"
              "&supplies=${Uri.encodeComponent(json.encode(proceedSupply))}"
              "&qdata=${Uri.encodeComponent(json.encode(proceedQty))}";

          try {
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );

            Logdata.userEmail = "";
            user.email = "";
            user.name = "";
            user.tel = "";
            Logdata.canteen = false;
            checkoutdata.clear();
            cartdata.clear();
            SystemNavigator.pop();
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${e.toString()}')),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.2),
          backgroundColor: Colors.transparent,
        ),
        child: Container(
          height: 50, // Increased height
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal[700]!, Colors.teal[900]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Text(
              'Place Order',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
