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
      var url = Uri.parse("http://192.168.195.67/Firebase/canteenowner1.php");
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

  Future<void> _handleOrderComplete(Map<String, dynamic> order) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
            ),
          );
        },
      );

      var url = Uri.parse("http://192.168.195.67/Firebase/updatestate.php");
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

      Navigator.of(context).pop(); // Close loading dialog

      if (response.statusCode == 200) {
        // Remove the completed order from the list
        setState(() {
          orderData.removeWhere((item) => item['oid'] == order['oid']);
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Order marked as completed'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // Send notification
        try {
          var notifyUrl;
          if (Logdata.userEmail == "Ayush@gmail.com") {
            notifyUrl = Uri.parse(
                "http://192.168.195.67/Firebase/notifications/userordernotify1.php");
          } else if (Logdata.userEmail == "So@gmail.com") {
            notifyUrl = Uri.parse(
                "http://192.168.195.67/Firebase/notifications/userordernotify2.php");
          } else if (Logdata.userEmail == "Hela@gmail.com") {
            notifyUrl = Uri.parse(
                "http://192.168.195.67/Firebase/notifications/userordernotify3.php");
          } else if (Logdata.userEmail == "Leyons@gmail.com") {
            notifyUrl = Uri.parse(
                "http://192.168.195.67/Firebase/notifications/userordernotify4.php");
          } else if (Logdata.userEmail == "Finagle@gmail.com") {
            notifyUrl = Uri.parse(
                "http://192.168.195.67/Firebase/notifications/userordernotify5.php");
          } else if (Logdata.userEmail == "Ocean@gmail.com") {
            notifyUrl = Uri.parse(
                "http://192.168.195.67/Firebase/notifications/userordernotify6.php");
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
      Navigator.of(context).pop(); // Close loading dialog
      log("Error updating state: $ex");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update order'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey[600],
        currentIndex: 0, // Highlight "Home"
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on Home, refresh data
              fetchOrderData();
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Order()),
              );
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
            ], // Amber gradient matching user home
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
                      'Meal Matrix',
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
                  'Manage your canteen orders efficiently',
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
                          Icons.restaurant,
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
                              'Logged in as: ${Logdata.userEmail}',
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

                // Pending Orders Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Pending Orders',
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

                // Orders List
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.teal),
                          ),
                        )
                      : orderData.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_circle_outline,
                                    size: 80,
                                    color: Colors.teal,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No pending orders',
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
                                return OrderCard(
                                  imageUrl: order['image'],
                                  title: order['name'],
                                  quantity: order['qty'].toString(),
                                  price: 'Rs.${order['price']}',
                                  customerEmail: order['email'],
                                  orderTime: order['stime'],
                                  onComplete: () => _handleOrderComplete(order),
                                );
                              },
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

class OrderCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String quantity;
  final String price;
  final String customerEmail;
  final String orderTime;
  final VoidCallback onComplete;

  const OrderCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.quantity,
    required this.price,
    required this.customerEmail,
    required this.orderTime,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.grey),
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
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
                          const SizedBox(width: 8),
                          Text(
                            price,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Customer: ${customerEmail.split('@')[0]}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Ordered at: $orderTime',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Mark as Complete'),
                onPressed: onComplete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
