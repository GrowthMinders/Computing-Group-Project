// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:mealmatrix/CanteenOwner.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:http/http.dart' as http;
import 'package:mealmatrix/main.dart';
import 'dart:convert';
import 'dart:developer';

// Remove the first Order class completely and keep only the second one

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

List<Map<String, dynamic>> orderData = [];

class _OrderState extends State<Order> {
  @override
  void initState() {
    super.initState();
    fetchOrderData();
  }

  Future<void> fetchOrderData() async {
    try {
      var url = Uri.parse("http://192.168.177.67/Firebase/canteenowner2.php");
      Map<String, String> body = {};

      if (Logdata.userEmail == "Ayush@gmail.com") {
        body = {'supply': "Ayush", 'canteen': "Edge"};
      } else if (Logdata.userEmail == "So@gmail.com") {
        body = {'supply': "So Cafe", 'canteen': "Edge"};
      } else if (Logdata.userEmail == "Leyons@gmail.com") {
        body = {'supply': "Leyons", 'canteen': "Audi"};
      } else if (Logdata.userEmail == "Ocean@gmail.com") {
        body = {'supply': "Ocean", 'canteen': "Hostel"};
      } else if (Logdata.userEmail == "Hela@gmail.com") {
        body = {'supply': "Hela Bojun", 'canteen': "Edge"};
      } else if (Logdata.userEmail == "Finagle@gmail.com") {
        body = {'supply': "Finagle", 'canteen': "Finagle"};
      }

      var response = await http.post(
        url,
        body: body,
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        setState(() {
          orderData = responseData.map<Map<String, dynamic>>((record) {
            return {
              'name': record['name'],
              'qty': record['qty'],
              'image': record['image'],
              'price': record['price'],
            };
          }).toList();
        });
      } else {
        log("Failed to fetch data: ${response.statusCode}");
      }
    } catch (ex) {
      log("Unexpected error: $ex");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        title: Text(
          'Today Sales',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                'lib/assets/images/Meal Matrix Logo.png',
                width: 30,
                height: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: orderData.length,
              itemBuilder: (context, index) {
                final order = orderData[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: OrderItem(
                    imageUrl: order['image'],
                    title: '${order['name']} (${order['qty']})',
                    price: 'Rs.${order['price']}',
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Summary(),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(
            Icons.home,
            'Home',
            const Color.fromARGB(255, 74, 73, 73),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Canteen()),
              );
            },
          ),
          _buildBottomNavItem(
            Icons.list_alt,
            'Orders',
            const Color.fromARGB(255, 74, 73, 73),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Order()),
              );
            },
          ),
          _buildBottomNavItem(
            Icons.settings,
            'Settings',
            const Color.fromARGB(255, 74, 73, 73),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final int? quantity;

  const OrderItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(price, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class calculate {
  static double caltotal() {
    return orderData.fold(
      0,
      (sum, item) => sum + (item['price'] * item['qty']),
    );
  }

  static double calitems() {
    return orderData.fold(0, (sum, item) => sum + item['qty']);
  }
}

class Summary extends StatelessWidget {
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

Widget _buildBottomNavItem(
  IconData icon,
  String label,
  Color color, {
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ],
    ),
  );
}
