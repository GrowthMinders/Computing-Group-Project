// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, unnecessary_brace_in_string_interps, use_build_context_synchronously, library_private_types_in_public_api, use_super_parameters

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
      var url = Uri.parse("http://192.168.177.67/Firebase/cartrendering.php");

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: _buildCartItem(cartdata)),
            SizedBox(height: 8),
            Summa(
              total: total,
              items: items,
            ), // Replaced "summa" with SummarySection
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 30),
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
                  Text('Price: Rs. ${product['price'].toInt()}'),
                  Text('Qty: ${product['qty']}'),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () async {
                        try {
                          var url = Uri.parse(
                            "http://192.168.177.67/Firebase/prodelcart.php",
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
                              SnackBar(
                                content: Text('Item deleted successfully'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to delete item')),
                            );
                          }
                        } catch (ex) {
                          log("Unexpected error: $ex");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('An error occurred while deleting'),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.delete_forever,
                            size: 26,
                            color: Colors.red,
                          ),
                          SizedBox(width: 4),
                        ],
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

class Summa extends StatelessWidget {
  final double total;
  final double items;

  const Summa({required this.total, required this.items, Key? key})
      : super(key: key);

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
