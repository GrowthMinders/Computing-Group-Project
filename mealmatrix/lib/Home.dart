// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mealmatrix/Audi.dart';
import 'package:mealmatrix/Edge.dart';
import 'package:mealmatrix/Finagle.dart';
import 'package:mealmatrix/Hostel.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:mealmatrix/Setting.dart';

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
                        print('Shopping cart tapped');
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
                SizedBox(height: 24),
                Text(
                  'Favorite Item',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFavoriteItem(
                      onTap: () {},
                      title: 'Beverages',
                      imageUrl:
                          'https://storage.googleapis.com/a1aa/image/_tbwa4NqyO8JdUHgdtKvE0pi1xaPKznfgqmhJQ_4iw8.jpg',
                    ),
                    _buildFavoriteItem(
                      onTap: () {},
                      title: 'Snack',
                      imageUrl:
                          'https://storage.googleapis.com/a1aa/image/2T064IIpcPmNhH1_AlRCY5itDO2q5O3WwJJAsjmsx2U.jpg',
                    ),
                    _buildFavoriteItem(
                      onTap: () {},
                      title: 'Seafood',
                      imageUrl:
                          'https://storage.googleapis.com/a1aa/image/-_TTB_8AAQeB5a024LOb3RU1Afnl7LuZkY21dcTzV1M.jpg',
                    ),
                    _buildFavoriteItem(
                      onTap: () {},
                      title: 'Dessert',
                      imageUrl:
                          'https://storage.googleapis.com/a1aa/image/aFYxmsVb_Wi-zQM7Ya9vWvfmURQgaQOg2pfE6dEMYG8.jpg',
                    ),
                  ],
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
                      imagePath: 'lib/assets/images/Finagle.jpg',
                      onTap: () async {
                        try {
                          final response = await http.get(
                            Uri.parse(
                              'http://192.168.72.67/Firebase/Menus/Finagle.php',
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
                      imagePath: 'lib/assets/images/Hostel.jpeg',
                      onTap: () async {
                        try {
                          final response = await http.get(
                            Uri.parse(
                              'http://192.168.72.67/Firebase/Menus/Hostel.php',
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
                      imagePath: 'lib/assets/images/Edge.jpeg',
                      onTap: () async {
                        try {
                          final response = await http.get(
                            Uri.parse(
                              'http://192.168.72.67/Firebase/Menus/Edge.php',
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
                      imagePath: 'lib/assets/images/Audi.jpg',
                      onTap: () async {
                        try {
                          final response = await http.get(
                            Uri.parse(
                              'http://192.168.72.67/Firebase/Menus/Audi.php',
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
                          MaterialPageRoute(builder: (context) => Home()),
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
                          MaterialPageRoute(builder: (context) => Audi()),
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

  Widget _buildFavoriteItem({
    required String title,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
          SizedBox(height: 4),
          Text(title, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCanteenItem({
    required String title,
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
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
