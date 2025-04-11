// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mealmatrix/Favorite.dart';
import 'package:mealmatrix/Home.dart';
import 'package:mealmatrix/Setting.dart';

// Remove the first Order class completely and keep only the second one

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        title: Text(
          'Order',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                'lib/assets/images/Meal Matrix Logo.png',
                width: 30,
                height: 30,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Order',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            OrderItem(
              imageUrl:
                  'https://storage.googleapis.com/a1aa/image/zZWBNy-ZMrLFpDvmrw0I_HFbQ8SRu0qDhdZcgKf28-4.jpg',
              title: 'Sausage Delight Pizza',
              price: 'Rs.1500.00',
              quantity: 1,
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order history',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See more',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 16),
            OrderItem(
              imageUrl:
                  'https://storage.googleapis.com/a1aa/image/EbS6s6nw25NeyVlP9UAqOLDb6AObI_-lB2Ws4S1gF2o.jpg',
              title: 'Fish Rice & Curry',
              price: 'Rs.380.00',
              quantity: null,
            ),
          ],
        ),
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
                MaterialPageRoute(builder: (context) => Order()),
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
            'Settings',
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
}

class OrderItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;
  final int? quantity;

  const OrderItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(imageUrl, width: 80, height: 80, fit: BoxFit.cover),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(price, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          if (quantity != null) ...[
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () {},
            ),
            Row(
              children: [
                IconButton(icon: Icon(Icons.remove), onPressed: () {}),
                Text('$quantity'),
                IconButton(icon: Icon(Icons.add), onPressed: () {}),
              ],
            ),
          ],
          IconButton(
            icon: Icon(Icons.delete, color: Colors.grey),
            onPressed: () {},
          ),
        ],
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
