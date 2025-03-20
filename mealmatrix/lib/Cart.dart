// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types

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
      var url = Uri.parse("http://192.168.108.67/Firebase/cartrendering.php");

      var response = await http.post(url, body: {'email': Logdata.userEmail});

      if (response.statusCode == 200) {
        List<List<dynamic>> cart = json.decode(responseBody);

        cartdata =
            cart
                .map(
                  (record) => {
                    'image': record[0], // image
                    'name': record[1], // name
                    'email': record[2], // email
                    'price': record[3], // price — make sure this exists!
                    'telephone': record[4], // telephone
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

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildCartItem(
                imageUrl:
                    'https://storage.googleapis.com/a1aa/image/QMXUWWHvrTRmpZszFxWT0SzxoMG0HD0rXtW4PVCWILE.jpg',
                title: 'Sausage Delight Pizza',
                price: 1500.00,
                quantity: 1,
                isFavorite: true,
              ),
              SizedBox(height: 16),
              _buildCartItem(
                imageUrl:
                    'https://storage.googleapis.com/a1aa/image/s8PLeCgTgR5ztg3Npebh9XqmsAf7DGSSUk3VLWO623M.jpg',
                title: 'Chicken Kottu',
                price: 670.00,
                quantity: 1,
                isFavorite: false,
              ),
              Spacer(),
              _buildSummarySection(itemCount: 2, totalPrice: 2170.00),
              SizedBox(height: 16),
              _buildCheckoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartItem({
    required String imageUrl,
    required String title,
    required double price,
    required int quantity,
    required bool isFavorite,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
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
                SizedBox(height: 8),
                Text(
                  'Rs.${price.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              SizedBox(height: 8),
              Icon(Icons.delete, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection({
    required int itemCount,
    required double totalPrice,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Items ($itemCount)'),
              Text('Rs.${totalPrice.toStringAsFixed(2)}'),
            ],
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
                'Rs.${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Checkout()),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.green,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Center(
        child: Text(
          'Check Out',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
