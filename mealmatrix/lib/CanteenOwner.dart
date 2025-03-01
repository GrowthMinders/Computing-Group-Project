// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mealmatrix/Order.dart';

import 'package:mealmatrix/Setting.dart';

class Canteen extends StatefulWidget {
  const Canteen({super.key});

  @override
  CanteenState createState() => CanteenState();
}

class CanteenState extends State<Canteen> {
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
                          MaterialPageRoute(builder: (context) => Canteen()),
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
                          MaterialPageRoute(builder: (context) => Order()),
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
