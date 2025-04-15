// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:mealmatrix/OrderHistory.dart';
import 'package:mealmatrix/ProductDetails.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:mealmatrix/Home.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mealmatrix/main.dart';

class Favorite extends StatelessWidget {
  static List<Map<String, dynamic>> favdata = [];
  Future<void> renderfav(String responseBody) async {
    try {
      var url = Uri.parse(
        "http://192.168.177.67/Firebase/favoriterendering.php",
      );

      var response = await http.post(url, body: {'email': Logdata.userEmail});

      if (response.statusCode == 200) {
        List<List<dynamic>> fav = json.decode(responseBody);

        favdata =
            fav
                .map(
                  (record) => {
                    'name': record[1],
                    'supply': record[3],
                    'canteen': record[4],
                    'image': record[5],
                    'price': record[6],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Favorites'),
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
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [FavoriteItem(favrendering.favdata)]),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBottomNavItem(
              Icons.home,
              'Home',
              const Color.fromARGB(255, 74, 73, 73),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
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
                  MaterialPageRoute(builder: (context) => OrderHistory()),
                );
              },
            ),
            _buildBottomNavItem(
              Icons.favorite,
              'Favorite',
              const Color.fromARGB(255, 74, 73, 73),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Favorite()),
                );
              },
            ),
            _buildBottomNavItem(
              Icons.settings,
              'Setting',
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
      ),
    );
  }
}

Widget FavoriteItem(List<dynamic> favdata) {
  if (favdata.isEmpty) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'No favorites yet!',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16)),
      const SizedBox(height: 8),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: favdata.length,
        itemBuilder: (context, index) {
          final product = favdata[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ProductDetail(
                        image: product['image'],
                        name: product['name'],
                        price: product['price'].toString(),
                        supply: product['supply'],
                        canteen: product['canteen'],
                      ),
                ),
              );
            },
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product['image']),
                    radius: 30,
                  ),
                  title: Text(product['name']),
                  subtitle: Text(
                    'Rs.${product['price']}\n${product['supply']}\n${product['canteen']}',
                  ),
                ),
                const Divider(),
              ],
            ),
          );
        },
      ),
    ],
  );
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
