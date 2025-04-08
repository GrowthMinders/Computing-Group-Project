// ignore_for_file: file_names, unused_import, non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mealmatrix/Audi.dart';
import 'package:mealmatrix/Cart.dart';
import 'package:mealmatrix/Edge.dart';
import 'package:mealmatrix/Favorite.dart';
import 'package:mealmatrix/Finagle.dart';
import 'package:mealmatrix/Hostel.dart';
import 'package:http/http.dart' as http;
import 'package:mealmatrix/OrderHistory.dart';
import 'package:mealmatrix/ProductDetails.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:mealmatrix/Home.dart';

import 'package:mealmatrix/Setting.dart';
import 'package:mealmatrix/main.dart';

class favrendering {
  static List<Map<String, dynamic>> favdata = [];

  Future<void> renderfav() async {
    try {
      var url = Uri.parse(
        "http://10.16.130.245/Firebase/favoriterendering.php",
      );

      var response = await http.post(url, body: {'email': Logdata.userEmail});

      if (response.statusCode == 200) {
        List<dynamic> fav = json.decode(
          response.body,
        ); // Use response.body directly

        favdata =
            fav
                .map(
                  (record) => {
                    'name': record['name'],
                    'supply': record['supply'],
                    'canteen': record['canteen'],
                    'image': record['image'],
                    'price': record['price'],
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

class Home extends StatefulWidget {
  const Home({super.key});

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
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Meal Matrix',
                        style: TextStyle(fontSize: 40, fontFamily: 'Lobster'),
                      ),
                    ),
                    Align(
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
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Order your favourite food!',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search food',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Cart()),
                        );
                      },
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/kottu.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
                SizedBox(height: 22),
                Row(
                  children: [
                    Text(
                      'Favorite Items',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Favorite()),
                        );
                      },
                      child: Text(
                        'See more',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                FavoriteItem(
                  favrendering.favdata.sublist(
                    0,
                    favrendering.favdata.length < 4
                        ? favrendering.favdata.length
                        : 4,
                  ),
                ),

                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Canteen selection',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  children: [
                    _buildCanteenItem(
                      title: 'Finagle Canteen',
                      time: '8.0 AM - 5.0 PM',
                      telephone: '0761571745',
                      location: 'map location', // map location
                      imagePath: 'lib/assets/images/Finagle.jpg',
                      onTap: () async {
                        try {
                          final response = await http.get(
                            Uri.parse(
                              'http://10.16.130.245/Firebase/Menus/Finagle.php',
                            ),
                          );

                          if (response.statusCode == 200) {
                            Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) => Finagle(),
                              ),
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
                    _buildCanteenItem(
                      title: 'Hostel Canteen',
                      time: '8.0 AM - 5.0 PM',
                      telephone: '0761571744',
                      location: 'map location', // map location
                      imagePath: 'lib/assets/images/Hostel.jpeg',
                      onTap: () async {
                        try {
                          final response = await http.get(
                            Uri.parse(
                              'http://10.16.130.245/Firebase/Menus/Hostel.php',
                            ),
                          );

                          if (response.statusCode == 200) {
                            Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(builder: (context) => Hostel()),
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
                    _buildCanteenItem(
                      title: 'Edge Canteen',
                      time: '8.0 AM - 5.0 PM',
                      telephone: '0761571743',
                      location: 'map location', // map location
                      imagePath: 'lib/assets/images/Edge.jpeg',
                      onTap: () async {
                        try {
                          final response = await http.get(
                            Uri.parse(
                              'http://10.16.130.245/Firebase/Menus/Edge.php',
                            ),
                          );

                          if (response.statusCode == 200) {
                            Navigator.push(
                              // ignore: use_build_context_synchronously
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
                    _buildCanteenItem(
                      title: 'Audi Canteen',
                      time: '8.0 AM - 5.0 PM',
                      telephone: '0761571845',
                      location: 'map location', // map location
                      imagePath: 'lib/assets/images/Audi.jpg',
                      onTap: () async {
                        try {
                          final response = await http.get(
                            Uri.parse(
                              'http://10.16.130.245/Firebase/Menus/Audi.php',
                            ),
                          );

                          if (response.statusCode == 200) {
                            Navigator.push(
                              // ignore: use_build_context_synchronously
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
                SizedBox(height: 3),
                Divider(),
                Row(
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
                          MaterialPageRoute(
                            builder: (context) => OrderHistory(),
                          ),
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
                          //change Audi name
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
                          //change Audi name
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

  Widget FavoriteItem(List<dynamic> favdata) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(height: 8),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: favdata.length, // Now it's only the first 4 items
          itemBuilder: (context, index) {
            final product = favdata[index];
            return Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product['image']),
                    radius: 30,
                  ),
                  title: Text(product['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${product['supply']}'),
                      Text('${product['canteen']}'),
                      Text('${product['price']}'),
                    ],
                  ),
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
                ),
                const Divider(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCanteenItem({
    required String title,
    required String time,
    required String telephone,
    required String location,
    required String imagePath,
    required VoidCallback onTap, // Add onTap as a required parameter
  }) {
    return GestureDetector(
      onTap: onTap, // Use the onTap parameter
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            time,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            telephone,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            location,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
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
