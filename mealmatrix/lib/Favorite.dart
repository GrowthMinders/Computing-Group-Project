// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:mealmatrix/Home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Favorite());
  }
}

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Favorite Item'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/Meal Matrix Logo.jpg'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            FavoriteItem(),
            FavoriteItem(),
            FavoriteItem(),
            FavoriteItem(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
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
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                'https://storage.googleapis.com/a1aa/image/Rc6YVYZQKB9diw1yRqd9-NiyY60-zzT9JE4Kvp8VP0c.jpg',
              ),
            ),
            SizedBox(width: 16.0),
          ],
        ),
      ),
    );
  }
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
