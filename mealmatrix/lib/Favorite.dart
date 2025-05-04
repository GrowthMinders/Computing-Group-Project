// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, non_constant_identifier_names, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:mealmatrix/Home.dart';
import 'package:mealmatrix/Order.dart';
import 'package:mealmatrix/OrderHistory.dart';
import 'package:mealmatrix/ProductDetails.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:mealmatrix/main.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  FavoriteState createState() => FavoriteState();
}

class FavoriteState extends State<Favorite> {
  static List<Map<String, dynamic>> favdata = [];

  @override
  void initState() {
    super.initState();
    renderfav().then((_) {
      setState(() {});
    });
  }

  Future<void> renderfav() async {
    try {
      var url =
          Uri.parse("http://192.168.8.101/Firebase/favoriterendering.php");
      var response = await http.post(url, body: {'email': Logdata.userEmail});

      if (response.statusCode == 200) {
        List<dynamic> fav = json.decode(response.body);
        setState(() {
          favdata = fav
              .map((record) => {
                    'name': record['name'],
                    'supply': record['supply'],
                    'canteen': record['canteen'],
                    'image': record['image'],
                    'price': record['price'].toString(),
                  })
              .toList();
        });
      } else {
        log("Failed to fetch data: ${response.statusCode}");
      }
    } catch (ex) {
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
      currentIndex = -1; // No highlight for canteen owners
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
      currentIndex = 2; // Highlight Favorite
      onHomeTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      };
      onOrdersTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrderHistory()),
        );
      };
      onFavoriteTap = () {
        // Already on Favorite, do nothing
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
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
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
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      kToolbarHeight -
                      MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Favorite Items',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 24),
                    FavoriteItem(favdata),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget FavoriteItem(List<dynamic> favdata) {
    if (favdata.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No favorites yet!',
            style: TextStyle(fontSize: 16, color: Colors.teal),
          ),
        ),
      );
    }

    return Column(
      children: favdata.map((product) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          elevation: 3,
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
              '${product['canteen']} • Rs. ${product['price']}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            trailing: GestureDetector(
              onTap: () async {
                try {
                  var url = Uri.parse(
                    "http://192.168.8.101/Firebase/favdelete.php",
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
                    log("Success: Favorite product removed");
                    setState(() {
                      favdata.removeWhere(
                        (item) =>
                            item['name'] == product['name'] &&
                            item['supply'] == product['supply'] &&
                            item['canteen'] == product['canteen'],
                      );
                    });
                  }
                } catch (ex) {
                  log("Unexpected error: $ex");
                }
              },
              child: const IconTheme(
                data: IconThemeData(size: 28, color: Colors.teal),
                child: Icon(Icons.delete_forever),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetail(
                    image: product['image'],
                    name: product['name'],
                    price: product['price'].toString(),
                    supply: product['supply'],
                    canteen: product['canteen'],
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
