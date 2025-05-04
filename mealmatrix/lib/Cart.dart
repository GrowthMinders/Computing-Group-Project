// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, unnecessary_brace_in_string_interps, use_build_context_synchronously, library_private_types_in_public_api, use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mealmatrix/Checkout.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mealmatrix/main.dart';

class Cart extends StatefulWidget {
  @override
  CartState createState() => CartState();
}

List<Map<String, dynamic>> cartdata = [];

class CartState extends State<Cart> {
  Future<void> rendercart() async {
    try {
      var url = Uri.parse("http://192.168.8.101/Firebase/cartrendering.php");

      var response = await http.post(url, body: {'email': Logdata.userEmail});

      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);
        cartdata = (decoded as List)
            .map(
              (record) => {
                'name': record['name'],
                'supply': record['supply'],
                'qty': record['qty'],
                'canteen': record['canteen'],
                'price': record['price'].toDouble(),
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

  double caltotal() {
    return cartdata.fold(0, (sum, item) => sum + (item['price'] * item['qty']));
  }

  double calitems() {
    return cartdata.fold(0, (sum, item) => sum + item['qty']);
  }

  @override
  void initState() {
    super.initState();
    rendercart();
  }

  @override
  Widget build(BuildContext context) {
    final total = caltotal();
    final items = calitems();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
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
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _buildCartItem(cartdata),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Summa(
                  total: total,
                  items: items,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Checkout()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: const Center(
                    child: Text(
                      'Check Out',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem(List<dynamic> cartdata) {
    if (cartdata.isEmpty) {
      return const Center(
        child: Text(
          'Your cart is empty!',
          style: TextStyle(fontSize: 16, color: Colors.teal),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: cartdata.length,
      itemBuilder: (context, index) {
        final product = cartdata[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white.withOpacity(0.9),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(product['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Supply: ${product['supply']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        'Canteen: ${product['canteen']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        'Price: Rs. ${product['price'].toInt()}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      Text(
                        'Qty: ${product['qty']}',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_forever,
                    size: 26,
                    color: Colors.teal,
                  ),
                  onPressed: () async {
                    try {
                      var url = Uri.parse(
                        "http://192.168.8.101/Firebase/prodelcart.php",
                      );

                      var response = await http.post(
                        url,
                        body: {
                          'name': product['name'],
                          'supply': product['supply'],
                          'canteen': product['canteen'],
                          'email': Logdata.userEmail,
                        },
                      );

                      if (response.statusCode == 200) {
                        rendercart();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item deleted successfully'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Failed to delete item')),
                        );
                      }
                    } catch (ex) {
                      log("Unexpected error: $ex");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('An error occurred while deleting'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Summa extends StatelessWidget {
  final double total;
  final double items;

  const Summa({required this.total, required this.items, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Items',
                  style: TextStyle(fontSize: 16, color: Colors.teal),
                ),
                Text(
                  '${items.toInt()}',
                  style: const TextStyle(fontSize: 16, color: Colors.teal),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                Text(
                  'Rs. ${total.toInt()}',
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
