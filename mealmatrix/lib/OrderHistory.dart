// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, non_constant_identifier_names, body_might_complete_normally_nullable, library_private_types_in_public_api, use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:mealmatrix/Favorite.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:mealmatrix/Home.dart';
import 'package:mealmatrix/Order.dart';
import 'package:mealmatrix/main.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  List<Map<String, dynamic>> oderhist = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchOrderHistory();
  }

  Future<void> fetchOrderHistory() async {
    try {
      var url = Uri.parse(
        "http://192.168.8.101/Firebase/orderhistoryrendering.php",
      );
      var response = await http.post(url, body: {'email': Logdata.userEmail});

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);

        setState(() {
          oderhist = responseData
              .map(
                (record) => {
                  'name': record['name'],
                  'supply': record['supply'],
                  'canteen': record['canteen'],
                  'price': record['price'],
                  'image': record['image'],
                  'date': record['date'],
                  'qty': record['qty'],
                },
              )
              .toList();
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch orders: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (ex) {
      setState(() {
        errorMessage = 'Unexpected error: $ex';
        isLoading = false;
      });
      log("Unexpected error: $ex");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define navigation items based on user type
    List<BottomNavigationBarItem> navItems;
    int currentIndex;
    VoidCallback? onHomeTap;
    VoidCallback? onOrdersTap;
    VoidCallback? onFavoriteTap;
    VoidCallback? onSettingTap;

    if (Logdata.userEmail == "Ayush@gmail.com" ||
        Logdata.userEmail == "So@gmail.com" ||
        Logdata.userEmail == "Leyons@gmail.com" ||
        Logdata.userEmail == "Ocean@gmail.com" ||
        Logdata.userEmail == "Hela@gmail.com" ||
        Logdata.userEmail == "Finagle@gmail.com" ||
        Logdata.userEmail == "ayushcafe2002@gmail.com") {
      navItems = const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
      ];
      currentIndex = 1; // Highlight Orders
      onHomeTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      };
      onOrdersTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Order()),
        );
      };
      onSettingTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
        );
      };
    } else {
      navItems = const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
      ];
      currentIndex = 1; // Highlight Orders
      onHomeTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      };
      onOrdersTap = () {
        // Already on OrderHistory, do nothing
      };
      onFavoriteTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Favorite()),
        );
      };
      onSettingTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
        );
      };
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Order History',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[600],
        currentIndex: currentIndex,
        onTap: (index) {
          if (Logdata.userEmail == "Ayush@gmail.com" ||
              Logdata.userEmail == "So@gmail.com" ||
              Logdata.userEmail == "Leyons@gmail.com" ||
              Logdata.userEmail == "Ocean@gmail.com" ||
              Logdata.userEmail == "Hela@gmail.com" ||
              Logdata.userEmail == "Finagle@gmail.com" ||
              Logdata.userEmail == "ayushcafe2002@gmail.com") {
            if (index == 0) onHomeTap?.call();
            if (index == 1) onOrdersTap?.call();
            if (index == 2) onSettingTap?.call();
          } else {
            if (index == 0) onHomeTap?.call();
            if (index == 1) onOrdersTap?.call();
            if (index == 2) onFavoriteTap?.call();
            if (index == 3) onSettingTap?.call();
          }
        },
        items: navItems,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE082), Color(0xFFFFB300)], // Amber gradient
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.teal))
                : errorMessage.isNotEmpty
                    ? Center(
                        child: Text(
                          errorMessage,
                          style:
                              const TextStyle(color: Colors.teal, fontSize: 16),
                        ),
                      )
                    : HistoryItem(oderhist),
          ),
        ),
      ),
    );
  }
}

class HistoryItem extends StatelessWidget {
  final List<Map<String, dynamic>> oderhist;

  const HistoryItem(this.oderhist, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (oderhist.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No orders yet!',
            style: TextStyle(fontSize: 16, color: Colors.teal),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Orders',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: oderhist.length,
          itemBuilder: (context, index) {
            final product = oderhist[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white.withOpacity(0.9),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product['image']),
                  radius: 30,
                ),
                title: Text(
                  product['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                subtitle: Text(
                  'Canteen: ${product['canteen']}\n'
                  'Price: Rs.${product['price']}\n'
                  'Quantity: ${product['qty']}\n'
                  'Date: ${product['date']}\n'
                  'Supply: ${product['supply']}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
