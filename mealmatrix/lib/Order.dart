// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mealmatrix/CanteenOwner.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:http/http.dart' as http;
import 'package:mealmatrix/main.dart';
import 'dart:convert';
import 'dart:developer';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  List<Map<String, dynamic>> orderData = [];
  bool isLoading = true;
  String canteenName = "Your Canteen";

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _determineCanteenName();
    fetchOrderData();
  }

  void _determineCanteenName() {
    if (Logdata.userEmail == "Ayush@gmail.com") {
      setState(() {
        canteenName = "Ayush Canteen";
      });
    } else if (Logdata.userEmail == "So@gmail.com") {
      setState(() {
        canteenName = "So Cafe";
      });
    } else if (Logdata.userEmail == "Leyons@gmail.com") {
      setState(() {
        canteenName = "Leyons Canteen";
      });
    } else if (Logdata.userEmail == "Ocean@gmail.com") {
      setState(() {
        canteenName = "Ocean Canteen";
      });
    } else if (Logdata.userEmail == "Hela@gmail.com") {
      setState(() {
        canteenName = "Hela Bojun";
      });
    } else if (Logdata.userEmail == "Finagle@gmail.com") {
      setState(() {
        canteenName = "Finagle Canteen";
      });
    }
  }

  Future<void> fetchOrderData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var url = Uri.parse("http://192.168.8.101/Firebase/canteenowner2.php");
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
          isLoading = false;
        });
      } else {
        log("Failed to fetch data: ${response.statusCode}");
        setState(() {
          isLoading = false;
        });
      }
    } catch (ex) {
      log("Unexpected error: $ex");
      setState(() {
        isLoading = false;
      });
    }
  }

  double calculateTotal() {
    return orderData.fold(
      0,
      (sum, item) =>
          sum + (double.parse(item['price']) * int.parse(item['qty'])),
    );
  }

  int calculateTotalItems() {
    return orderData.fold(
      0,
      (sum, item) => sum + int.parse(item['qty']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey[600],
        currentIndex: 1, // Highlight "Orders"
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Canteen()),
              );
              break;
            case 1:
              // Already on Orders, refresh data
              fetchOrderData();
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFE082),
              Color(0xFFFFB300)
            ], // Amber gradient matching home page
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Order History',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage(
                        'lib/assets/images/Meal Matrix Logo.png',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
                Text(
                  'Track sales and performance',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),

                const SizedBox(height: 20),

                // Canteen Info Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.storefront,
                          color: Colors.teal,
                          size: 36,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              canteenName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            Text(
                              'Today\'s Sales Summary',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Sales Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Completed Orders',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.teal),
                      onPressed: fetchOrderData,
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Sales List
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.teal),
                                ),
                              )
                            : orderData.isEmpty
                                ? Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.receipt_long,
                                          size: 80,
                                          color: Colors.teal,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'No sales today',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: orderData.length,
                                    itemBuilder: (context, index) {
                                      final order = orderData[index];
                                      return SaleItemCard(
                                        imageUrl: order['image'],
                                        title: order['name'],
                                        quantity: order['qty'],
                                        price: order['price'],
                                      );
                                    },
                                  ),
                      ),
                      if (orderData.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: SalesSummaryCard(
                            totalItems: calculateTotalItems(),
                            totalAmount: calculateTotal(),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SaleItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String quantity;
  final String price;

  const SaleItemCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.quantity,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey[300],
                  child:
                      const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Qty: $quantity',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[800],
                          ),
                        ),
                      ),
                      Text(
                        'Rs.$price',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Total: Rs.${int.parse(price) * int.parse(quantity)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
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

class SalesSummaryCard extends StatelessWidget {
  final int totalItems;
  final double totalAmount;

  const SalesSummaryCard({
    Key? key,
    required this.totalItems,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.teal,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Items Sold',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  totalItems.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.white54, height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Revenue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Rs.${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
