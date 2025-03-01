// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:mealmatrix/ChangePassword.dart';
import 'package:mealmatrix/CustomerSupport.dart';
import 'package:mealmatrix/Home.dart';
import 'package:mealmatrix/Profile.dart';
import 'package:mealmatrix/main.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Setting());
  }
}

class Setting extends StatefulWidget {
  @override
  SettingState createState() => SettingState();
}

class user {
  static String name = "";
  static String email = "";
  static String tel = "";
}

class SettingState extends State<Setting> {
  bool isDarkMode = false;
  int currentIndex = 3; // Default to Settings

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        backgroundColor: Colors.green,
        title: Row(
          children: [
            Icon(Icons.settings, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                'lib/assets/images/Meal Matrix Logo.png',
              ),
              radius: 25,
            ),
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 50),
            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.person, color: Colors.green),
                title: Text('My Account'),
                onTap: () async {
                  try {
                    var url = Uri.parse(
                      "http://192.168.72.67/Firebase/profile.php",
                    );

                    var response = await http.post(
                      url,
                      body: {'email': Logdata.userEmail},
                    );
                    if (response.statusCode == 200) {
                      log("Success: Account information loaded");
                      List<dynamic> jsonResponse = json.decode(response.body);
                      user.name = jsonResponse[1];
                      user.email = jsonResponse[2];
                      user.tel = jsonResponse[4];
                      Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    }
                  } catch (ex) {
                    log("Unexpected error: $ex");
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.dark_mode, color: Colors.green),
                title: Text('Dark mode'),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.support, color: Colors.green),
                title: Text('Customer Support'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CustomerSupport()),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.lock, color: Colors.green),
                title: Text('Change password'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePassword()),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.green),
                title: Text('Log Out'),
                onTap: () {
                  Logdata.userEmail = "";
                  user.email = "";
                  user.name = "";
                  user.tel = "";
                  Logdata.canteen = false;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
              ),
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
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          _buildBottomNavItem(
            Icons.favorite,
            'Favorite',
            const Color.fromARGB(255, 74, 73, 73),
            onTap: () {
              // Placeholder for correct navigation
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
