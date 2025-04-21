// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:mealmatrix/Favorite.dart';
import 'package:mealmatrix/Home.dart';
import 'package:mealmatrix/Order.dart';
import 'package:mealmatrix/OrderHistory.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:mealmatrix/main.dart';

// Remove the StatelessWidget version completely and keep only the StatefulWidget

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
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
          SizedBox(height: 100),
          Center(
            child: CircleAvatar(
              radius: 75,
              backgroundImage: user.imageBytes != null
                  ? Image.memory(user.imageBytes!).image
                  : AssetImage('lib/assets/images/DefaultProfile.png'),
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name : ${user.name}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email : ${user.email}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password : **********',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Telephone number : ${user.tel}',
                    style: TextStyle(fontSize: 18),
                  ),
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
              if (Logdata.userEmail == "ayushcafe2002@gmail.com") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Order()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistory()),
                );
              }
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
