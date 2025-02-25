// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';

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
  int _selectedIndex = 0; // Track the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // You can navigate to different screens based on the index
    // For example:
    // if (index == 1) {
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersScreen()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Green header
            Container(
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
                  Text(
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
            ),
            const SizedBox(height: 16),

            // Search, notification and cart bar
            Padding(
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
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search menu, restaurant or etc',
                                border: InputBorder.none,
                                hintStyle: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.notifications_outlined),
                  const SizedBox(width: 8),
                  const Icon(Icons.shopping_cart_outlined),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Menu categories and items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Rice And Curry Section
                  const Text(
                    'Rice And Curry',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFoodItem(
                        'Vegetable\nRice And Curry',
                        'Rs.300.00',
                        'assets/images/a.jpg',
                      ),
                      _buildFoodItem(
                        'Chicken\nRice & Curry',
                        'Rs.420.00',
                        'assets/images/b.jpg',
                      ),
                      _buildFoodItem(
                        'Fish\nRice & Curry',
                        'Rs.380.00',
                        'assets/images/c.jpg',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Kottu Section
                  const Text(
                    'Kottu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFoodItem(
                        'Vegetable\nKottu',
                        'Rs.370.00',
                        'assets/images/d.jpg',
                      ),
                      _buildFoodItem(
                        'Egg\nKottu',
                        'Rs.470.00',
                        'assets/images/e.jpg',
                      ),
                      _buildFoodItem(
                        'Chicken\nKottu',
                        'Rs.670.00',
                        'assets/images/f.jpg',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Fried Rice Section
                  const Text(
                    'Fried Rice',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFoodItem(
                        'Vegetable\nFried Rice',
                        'Rs.350.00',
                        'assets/images/g.jpg',
                      ),
                      _buildFoodItem(
                        'Egg\nFried Rice',
                        'Rs.400.00',
                        'assets/images/h.jpg',
                      ),
                      _buildFoodItem(
                        'Chicken\nFried Rice',
                        'Rs.480.00',
                        'assets/images/i.jpg',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Tea & Coffee Section
                  const Text(
                    'Tea & Coffee',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFoodItem(
                        'Milk Tea',
                        'Rs.100.00',
                        'assets/images/j.jpg',
                      ),
                      _buildFoodItem(
                        'Milk Coffee',
                        'Rs.150.00',
                        'assets/images/k.jpg',
                      ),
                      _buildFoodItem(
                        'Black Tea',
                        'Rs.50.00',
                        'assets/images/l.jpg',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Snacks Section
                  const Text(
                    'Snacks',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFoodItem(
                        'Malu Pan',
                        'Rs.80.00',
                        'assets/images/m.jpg',
                      ),
                      _buildFoodItem(
                        'Sandwiches',
                        'Rs.120.00',
                        'assets/images/n.jpg',
                      ),
                      _buildFoodItem(
                        'Rolls',
                        'Rs.180.00',
                        'assets/images/o.jpg',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Desserts Section
                  const Text(
                    'Desserts',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFoodItem(
                        'Chocolate\nCake',
                        'Rs.150.00',
                        'assets/images/p.jpg',
                      ),
                      _buildFoodItem(
                        'Pudding',
                        'Rs.100.00',
                        'assets/images/q.jpg',
                      ),
                      _buildFoodItem(
                        'Ice Cream',
                        'Rs.180.00',
                        'assets/images/r.jpg',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),

            // Bottom Navigation Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(Icons.home, 'Home', 0),
                _buildBottomNavItem(Icons.list_alt, 'Orders', 1),
                _buildBottomNavItem(Icons.favorite, 'Favorite', 2),
                _buildBottomNavItem(Icons.settings, 'Settings', 3),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItem(String name, String price, String imageUrl) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.grey.shade300),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(Icons.add, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Text(
          price,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.green : Colors.black),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(color: isSelected ? Colors.green : Colors.black),
          ),
        ],
      ),
    );
  }
}
