// ignore_for_file: file_names, unused_import, non_constant_identifier_names, camel_case_types, use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';
import 'package:mealmatrix/Audi.dart';
import 'package:mealmatrix/Cart.dart';
import 'package:mealmatrix/Edge.dart';
import 'package:mealmatrix/Favorite.dart';
import 'package:mealmatrix/Finagle.dart';
import 'package:mealmatrix/Hostel.dart';
import 'package:mealmatrix/OrderHistory.dart';
import 'package:mealmatrix/ProductDetails.dart';
import 'package:mealmatrix/Profile.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:mealmatrix/main.dart';

class favrendering {
  static List<Map<String, dynamic>> favdata = [];

  Future<void> renderfav() async {
    try {
      var url =
          Uri.parse("http://192.168.8.101/Firebase/favoriterendering.php");
      var response = await http.post(url, body: {'email': Logdata.userEmail});

      if (response.statusCode == 200) {
        List<dynamic> fav = json.decode(response.body);
        favdata = fav
            .map((record) => {
                  'name': record['name'],
                  'supply': record['supply'],
                  'canteen': record['canteen'],
                  'image': record['image'],
                  'price': record['price'].toString(),
                })
            .toList();
      } else {
        log("Failed to fetch data: ${response.statusCode}");
      }
    } catch (ex) {
      log("Unexpected error: $ex");
    }
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    favrendering().renderfav().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[600],
        currentIndex: 0, // Highlight "Home"
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on Home, do nothing
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OrderHistory()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Favorite()),
              );
              break;
            case 3:
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
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
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
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            'lib/assets/images/Meal Matrix Logo.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Delicious food delivered fast at NSBM!',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: Colors.white.withOpacity(0.9),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: Colors.teal,
                                    size: 28,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Welcome',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        Text(
                                          Logdata.userEmail,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Cart()),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.teal,
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Promotional Banner
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage('lib/assets/images/kottu.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Text(
                        'Favorite Items',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Favorite()),
                          );
                        },
                        child: const Text(
                          'See more',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FavoriteItem(
                    favrendering.favdata.sublist(
                      0,
                      favrendering.favdata.length < 4
                          ? favrendering.favdata.length
                          : 4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Canteen Selection',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildCanteenCard(
                        title: 'Finagle Canteen',
                        time: '8.0 AM - 5.0 PM',
                        imagePath: 'lib/assets/images/Finagle.jpg',
                        onTap: () async {
                          try {
                            final response = await http.get(
                              Uri.parse(
                                'http://192.168.8.101/Firebase/Menus/Finagle.php',
                              ),
                            );
                            if (response.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Finagle()),
                              );
                              log("Data found");
                            } else {
                              log("Data not available");
                            }
                          } catch (ex) {
                            log("Unexpected error: $ex");
                          }
                        },
                      ),
                      _buildCanteenCard(
                        title: 'Hostel Canteen',
                        time: '8.0 AM - 5.0 PM',
                        imagePath: 'lib/assets/images/Hostel.jpeg',
                        onTap: () async {
                          try {
                            final response = await http.get(
                              Uri.parse(
                                'http://192.168.8.101/Firebase/Menus/Hostel.php',
                              ),
                            );
                            if (response.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Hostel()),
                              );
                              log("Data found");
                            } else {
                              log("Data not available");
                            }
                          } catch (ex) {
                            log("Unexpected error: $ex");
                          }
                        },
                      ),
                      _buildCanteenCard(
                        title: 'Edge Canteen',
                        time: '8.0 AM - 5.0 PM',
                        imagePath: 'lib/assets/images/Edge.jpeg',
                        onTap: () async {
                          try {
                            final response = await http.get(
                              Uri.parse(
                                'http://192.168.8.101/Firebase/Menus/Edge.php',
                              ),
                            );
                            if (response.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Edge()),
                              );
                              log("Data found");
                            } else {
                              log("Data not available");
                            }
                          } catch (ex) {
                            log("Unexpected error: $ex");
                          }
                        },
                      ),
                      _buildCanteenCard(
                        title: 'Audi Canteen',
                        time: '8.0 AM - 5.0 PM',
                        imagePath: 'lib/assets/images/Audi.jpg',
                        onTap: () async {
                          try {
                            final response = await http.get(
                              Uri.parse(
                                'http://192.168.8.101/Firebase/Menus/Audi.php',
                              ),
                            );
                            if (response.statusCode == 200) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Audi()),
                              );
                              log("Data found");
                            } else {
                              log("Data not available");
                            }
                          } catch (ex) {
                            log("Unexpected error: $ex");
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
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
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: favdata.map((product) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          color: Colors.white, // White card background
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
              style: TextStyle(color: Colors.grey[600]),
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

  Widget _buildCanteenCard({
    required String title,
    required String time,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // White card background
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
