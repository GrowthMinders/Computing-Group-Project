// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, unnecessary_brace_in_string_interps, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mealmatrix/Checkout.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mealmatrix/main.dart';

class cartrendering {
  static List<Map<String, dynamic>> cartdata = [];

  Future<void> rendercart(String responseBody) async {
    try {
      var url = Uri.parse("http://10.16.130.245/Firebase/cartrendering.php");

      var response = await http.post(url, body: {'email': Logdata.userEmail});

      if (response.statusCode == 200) {
        List<List<dynamic>> cart = json.decode(responseBody);

        cartdata =
            cart
                .map(
                  (record) => {
                    'name': record[1],
                    'supply': record[3],
                    'qty': record[4],
                    'canteen': record[5],
                    'price': record[6],
                    'image': record[7],
                  },
                )
                .toList();
      } else {
        log("Failed to fetch data: ${response.statusCode}");
      }
    } catch (ex) {
      log("Unexpected error: $ex");
    }
  }
}

double caltotal() {
  return cartrendering.cartdata.fold(
    0,
    (sum, item) => sum + (item['price'] * item['qty']),
  );
}

double calitems() {
  return cartrendering.cartdata.fold(0, (sum, item) => sum + (item['qty']));
}

final total = caltotal();
final items = calitems();

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // This removes the debug label
      home: Scaffold(
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
              _buildCartItem(cartrendering.cartdata),
              SizedBox(height: 16),
              Spacer(),
              Text('Items ${items}'),
              Text('Total ${total}'),
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
            ],
          ),
        ),
      ),
    );
  }
  // ... rest of your code remains the same ...

  Widget _buildCartItem(List<dynamic> cartdata) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cartdata.length,
          itemBuilder: (context, index) {
            final product = cartdata[index];
            return Column(
              children: [
                ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
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
                      Text('${product['supply']}'),
                      Text('${product['canteen']}'),
                      Text('${product['price']}'),
                      Text('${product['qty']}'),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            var url = Uri.parse(
                              "http://10.16.130.245/Firebase/prodelcart.php",
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Cart()),
                              );
                            }
                          } catch (ex) {
                            log("Unexpected error: $ex");
                          }
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
                            'Remove Product',
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
                const Divider(),
              ],
            );
          },
        ),
      ],
    );
  }
}
