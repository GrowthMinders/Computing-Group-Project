// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, unnecessary_brace_in_string_interps, use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mealmatrix/Checkout.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mealmatrix/main.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Map<String, dynamic>> cartdata = [];

  Future<void> rendercart() async {
    try {
      var url = Uri.parse("http://10.16.166.111/Firebase/cartrendering.php");

      var response = await http.post(url, body: {'email': Logdata.userEmail});

      if (response.statusCode == 200) {
        var decoded = json.decode(response.body);
        cartdata =
            (decoded as List)
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
    rendercart(); // fetch data when widget loads
  }

  @override
  Widget build(BuildContext context) {
    final total = caltotal();
    final items = calitems();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
      body:
          cartdata.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(child: _buildCartItem(cartdata)),
                    SizedBox(height: 16),
                    Text('Items: $items'),
                    Text('Total: Rs. $total'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Checkout()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Check Out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildCartItem(List<dynamic> cartdata) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: cartdata.length,
      itemBuilder: (context, index) {
        final product = cartdata[index];
        return Column(
          children: [
            ListTile(
              leading: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(product['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(product['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Supply: ${product['supply']}'),
                  Text('Canteen: ${product['canteen']}'),
                  Text('Price: Rs. ${product['price']}'),
                  Text('Qty: ${product['qty']}'),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        var url = Uri.parse(
                          "http://10.16.166.111/Firebase/prodelcart.php",
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
                        }
                      } catch (ex) {
                        log("Unexpected error: $ex");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Remove Product',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
