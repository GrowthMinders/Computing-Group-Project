// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealmatrix/Cart.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:mealmatrix/Home.dart';
import 'package:mealmatrix/OrderHistory.dart';
import 'package:mealmatrix/Favorite.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:mealmatrix/ProductDetails.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Finagle(),
    );
  }
}

class Finagle extends StatefulWidget {
  const Finagle({super.key});

  @override
  FinagleState createState() => FinagleState();
}

class FinagleState extends State<Finagle> {
  List<dynamic> products = [];
  List<dynamic> friedrice = [];
  List<dynamic> ricecurry = [];
  List<dynamic> kottu = [];
  List<dynamic> teacoffee = [];
  List<dynamic> snack = [];
  List<dynamic> desert = [];

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.108.67/Firebase/Menus/Finagle.php'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        log('Data loaded products');
        setState(() {
          products = jsonResponse;
          friedrice =
              products.where((p) => p['category'] == 'Fried Rice').toList();
          ricecurry =
              products.where((p) => p['category'] == 'Rice and Curry').toList();
          kottu = products.where((p) => p['category'] == 'Kottu').toList();
          teacoffee = products.where((p) => p['category'] == 'Drink').toList();
          snack = products.where((p) => p['category'] == 'Snack').toList();
          desert = products.where((p) => p['category'] == 'Desert').toList();
        });
      } else {
        log('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching products: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 16),
              _buildCategoryList('Rice and Curry', ricecurry),
              _buildCategoryList('Fried Rice', friedrice),
              _buildCategoryList('Kottu', kottu),
              _buildCategoryList('Drinks', teacoffee),
              _buildCategoryList('Snack', snack),
              _buildCategoryList('Desert', desert),
              const Divider(),
              _buildBottomNavBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 13, 176, 18),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Text(
            'Finagle Canteen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(
              'lib/assets/images/Meal Matrix Logo.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search menu, restaurant or etc',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 14),
                  icon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(String title, List<dynamic> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final product = items[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ProductDetail(
                          image: product['image'],
                          name: product['name'],
                          price: product['price'],
                          supply: product['supply'],
                          canteen: product['canteen'],
                        ),
                  ),
                );
              },
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(product['image']),
                      radius: 30,
                    ),
                    title: Text(product['name']),
                    subtitle: Text('Rs.${product['price']}'),
                  ),
                  const Divider(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildBottomNavItem(
          Icons.home,
          'Home',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          ),
        ),
        _buildBottomNavItem(
          Icons.list_alt,
          'Orders',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderHistory()),
          ),
        ),
        _buildBottomNavItem(
          Icons.favorite,
          'Favorite',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Favorite()),
          ),
        ),
        _buildBottomNavItem(
          Icons.settings,
          'Settings',
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Setting()),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blueGrey),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
