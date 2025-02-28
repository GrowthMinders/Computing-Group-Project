// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:mealmatrix/Favorite.dart';
import 'package:mealmatrix/Home.dart';
import 'package:mealmatrix/Setting.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Profile());
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: Icon(Icons.arrow_back, color: Colors.white),
        title: Text('My Account', style: TextStyle(color: Colors.white)),
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
      body: Column(
        children: [
          SizedBox(height: 100), // Increased height to lower the items
          Center(
            child: CircleAvatar(
              radius: 75,
              backgroundImage: NetworkImage(
                'https://storage.googleapis.com/a1aa/image/UXV79DBPDB0-gF-RsmCELmBK045-ZIMqvyz6OP-2orI.jpg',
              ),
            ),
          ),
          SizedBox(height: 40), // Increased height to lower the items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Name', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Email', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Student ID', style: TextStyle(fontSize: 18)),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Faculty', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: Row(
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
