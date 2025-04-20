// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, camel_case_types, use_build_context_synchronously

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
      body: SingleChildScrollView(
        child: Padding(
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
                  supply: item['supply'],
                  name: item['name'],
                  qty: item['qty'].toString(),
                  price: item['price'],
                ),
              ),
              SizedBox(height: 16),
              SummarySection(),
              SizedBox(height: 16),
              PaymentMethodSection(),
              SizedBox(height: 16),
              PlaceOrderButton(),
              SizedBox(height: 16),
            ],
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
              Text(supply, style: TextStyle(fontWeight: FontWeight.bold)),
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
                'Rs. ${total.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
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
        Text('Payment method', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Row(
          children: [
            Checkbox(
              value: cardSelected,
              onChanged: (value) {
                setState(() {
                  cardSelected = value!;
                  if (cardSelected) {
                    selectedMethod = 'Credit or Debit card';
                  } else {
                    selectedMethod = 'None';
                  }
                });
                log('Selected: $selectedMethod');
              },
              activeColor: Colors.green,
              checkColor: Colors.white,
            ),
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
    // Calculate total fresh here as well
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
          final String url =
              "http://192.168.177.67/Firebase/paymentgateway.php?"
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
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
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
