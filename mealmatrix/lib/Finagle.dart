// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import 'package:mealmatrix/Home.dart';
import 'package:mealmatrix/OrderHistory.dart';
import 'package:mealmatrix/Favorite.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:mealmatrix/ProductDetails.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const Finagle(),
    );
  }
}

class Finagle extends StatefulWidget {
  const Finagle({Key? key}) : super(key: key);

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

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _riceCurryKey = GlobalKey();
  final GlobalKey _friedRiceKey = GlobalKey();
  final GlobalKey _kottuKey = GlobalKey();
  final GlobalKey _drinksKey = GlobalKey();
  final GlobalKey _snackKey = GlobalKey();
  final GlobalKey _desertKey = GlobalKey();

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.8.101/Firebase/Menus/Finagle.php'),
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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCategory(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      final RenderBox box = context.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero).dy;
      _scrollController.animateTo(
        _scrollController.offset + position - 80,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Finagle Canteen',
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
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
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
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE082), Color(0xFFFFB300)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.white, width: 1),
                  ),
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: SizedBox(
                      height: 48,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        children: [
                          _buildCategoryButton('Rice and Curry', _riceCurryKey),
                          _buildCategoryButton('Fried Rice', _friedRiceKey),
                          _buildCategoryButton('Kottu', _kottuKey),
                          _buildCategoryButton('Drinks', _drinksKey),
                          _buildCategoryButton('Snack', _snackKey),
                          _buildCategoryButton('Desert', _desertKey),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      _buildCategoryList(
                          'Rice and Curry', ricecurry, _riceCurryKey),
                      _buildCategoryList(
                          'Fried Rice', friedrice, _friedRiceKey),
                      _buildCategoryList('Kottu', kottu, _kottuKey),
                      _buildCategoryList('Drinks', teacoffee, _drinksKey),
                      _buildCategoryList('Snack', snack, _snackKey),
                      _buildCategoryList('Desert', desert, _desertKey),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String title, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: () => _scrollToCategory(key),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.teal[700],
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList(String title, List<dynamic> items, GlobalKey key) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ),
        const Divider(),
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
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product['image'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Rs.${product['price']}',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                            Text(
                              product['supply'],
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                            Text(
                              product['canteen'],
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
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
          Icon(icon, color: Colors.grey[600]),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
