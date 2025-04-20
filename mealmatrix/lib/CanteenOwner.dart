// ignore_for_file: file_names, deprecated_member_use, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mealmatrix/Order.dart';
import 'package:http/http.dart' as http;
import 'package:mealmatrix/Setting.dart';
import 'package:mealmatrix/main.dart';
import 'dart:convert';
import 'dart:developer';

class Canteen extends StatefulWidget {
  const Canteen({Key? key}) : super(key: key);

  @override
  CanteenState createState() => CanteenState();
}

class CanteenState extends State<Canteen> {
  List<Map<String, dynamic>> orderData = [];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    fetchOrderData();
  }

  Future<void> fetchOrderData() async {
    try {
      var url = Uri.parse("http://192.168.177.67/Firebase/canteenowner1.php");
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
              'oid': record['oid'],
              'name': record['name'],
              'qty': record['qty'],
              'image': record['image'],
              'price': record['price'],
              'stime': record['stime'],
              'email': record['email'],
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

  Future<void> _handleOrderComplete(Map<String, dynamic> order) async {
    try {
      var url = Uri.parse("http://192.168.177.67/Firebase/updatestate.php");
      Map<String, String> body = {};

      if (Logdata.userEmail == "Ayush@gmail.com") {
        body = {
          'name': order['name'],
          'supply': "Ayush",
          'canteen': "Edge",
          'stime': order['stime'],
          'email': order['email'],
        };
      } else if (Logdata.userEmail == "So@gmail.com") {
        body = {
          'name': order['name'],
          'supply': "So Cafe",
          'canteen': "Edge",
          'stime': order['stime'],
          'email': order['email'],
        };
      } else if (Logdata.userEmail == "Hela@gmail.com") {
        body = {
          'name': order['name'],
          'supply': "Hela Bojun",
          'canteen': "Edge",
          'stime': order['stime'],
          'email': order['email'],
        };
      } else if (Logdata.userEmail == "Leyons@gmail.com") {
        body = {
          'name': order['name'],
          'supply': "Leyons",
          'canteen': "Audi",
          'stime': order['stime'],
          'email': order['email'],
        };
      } else if (Logdata.userEmail == "Finagle@gmail.com") {
        body = {
          'name': order['name'],
          'supply': "Finagle",
          'canteen': "Finagle",
          'stime': order['stime'],
          'email': order['email'],
        };
      } else if (Logdata.userEmail == "Ocean@gmail.com") {
        body = {
          'name': order['name'],
          'supply': "Ocean",
          'canteen': "Hostel",
          'stime': order['stime'],
          'email': order['email'],
        };
      }

      var response = await http.post(url, body: body);

      if (response.statusCode == 200) {
        // Remove the completed order from the list
        setState(() {
          orderData.removeWhere((item) => item['oid'] == order['oid']);
        });

        // Send notification
        try {
          var notifyUrl;
          if (Logdata.userEmail == "Ayush@gmail.com") {
            notifyUrl = Uri.parse(
                "http://192.168.177.67/Firebase/notifications/userordernotify1.php");
          } else if (Logdata.userEmail == "So@gmail.com") {
            notifyUrl = Uri.parse(
                "http://192.168.177.67/Firebase/notifications/userordernotify2.php");
          } else if (Logdata.userEmail == "Hela@gmail.com") {
            notifyUrl = Uri.parse(
                "http://192.168.177.67/Firebase/notifications/userordernotify3.php");
          } else if (Logdata.userEmail == "Leyons@gmail.com") {
            notifyUrl = Uri.parse(
                "http://192.168.177.67/Firebase/notifications/userordernotify4.php");
          } else if (Logdata.userEmail == "Finagle@gmail.com") {
            notifyUrl = Uri.parse(
                "http://192.168.177.67/Firebase/notifications/userordernotify5.php");
          } else if (Logdata.userEmail == "Ocean@gmail.com") {
            notifyUrl = Uri.parse(
                "http://192.168.177.67/Firebase/notifications/userordernotify6.php");
          }

          await http.post(notifyUrl, body: {
            'email': order['email'],
            'oid': order['oid'].toString(),
          });
        } catch (ex) {
          log("Error sending notification: $ex");
        }
      }
    } catch (ex) {
      log("Error updating state: $ex");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Stack(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Meal Matrix',
                        style: TextStyle(fontSize: 40, fontFamily: 'Lobster'),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(
                          'lib/assets/images/Meal Matrix Logo.png',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                const SizedBox(height: 16),
                Column(
                  children: orderData.map((order) {
                    return Column(
                      children: [
                        Orders(
                          imageUrl: order['image'],
                          title: order['name'] + " (${order['qty']})",
                          price: 'Rs.${order['price']}',
                          onIconPressed: () => _handleOrderComplete(order),
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBottomNavItem(
                      Icons.home,
                      'Home',
                      const Color.fromARGB(255, 74, 73, 73),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Canteen(),
                          ),
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
                          MaterialPageRoute(
                            builder: (context) => const Order(),
                          ),
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
              ],
            ),
          ),
        ),
      ),
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
}

class Orders extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final int? quantity;
  final VoidCallback? onIconPressed;

  const Orders({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.quantity,
    this.onIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
                  ),
                ),
                Text(price, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: onIconPressed,
          ),
        ],
      ),
    );
  }
}
