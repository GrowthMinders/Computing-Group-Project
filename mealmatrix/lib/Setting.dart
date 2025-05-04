// ignore_for_file: use_build_context_synchronously, deprecated_member_use, use_key_in_widget_constructors, file_names, camel_case_types, unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';
import 'dart:typed_data';
import 'package:mealmatrix/CanteenOwner.dart';
import 'package:mealmatrix/ChangePassword.dart';
import 'package:mealmatrix/CustomerSupport.dart';
import 'package:mealmatrix/Favorite.dart';
import 'package:mealmatrix/Home.dart';
import 'package:mealmatrix/Order.dart';
import 'package:mealmatrix/OrderHistory.dart';
import 'package:mealmatrix/Profile.dart';
import 'package:mealmatrix/deleterequest.dart';
import 'package:mealmatrix/main.dart';

class SettingScreen extends StatelessWidget {
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
  static Uint8List? imageBytes;
}

class SettingState extends State<Setting> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    // Define navigation items based on user type
    List<BottomNavigationBarItem> navItems;
    int currentIndex;
    VoidCallback? onHomeTap;
    VoidCallback? onOrdersTap;
    VoidCallback? onFavoriteTap;
    VoidCallback? onSettingTap;

    if (Logdata.userEmail == "Ayush@gmail.com" ||
        Logdata.userEmail == "So@gmail.com" ||
        Logdata.userEmail == "Leyons@gmail.com" ||
        Logdata.userEmail == "Ocean@gmail.com" ||
        Logdata.userEmail == "Hela@gmail.com" ||
        Logdata.userEmail == "Finagle@gmail.com") {
      // Canteen owner navigation
      navItems = const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
      ];
      currentIndex = 2; // Highlight "Setting"
      onHomeTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Canteen()),
        );
      };
      onOrdersTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Order()),
        );
      };
      onSettingTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
        );
      };
    } else {
      // Regular user navigation
      navItems = const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
      ];
      currentIndex = 3; // Highlight "Setting"
      onHomeTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      };
      onOrdersTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrderHistory()),
        );
      };
      onFavoriteTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Favorite()),
        );
      };
      onSettingTap = () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Setting()),
        );
      };
    }

    return Scaffold(
      appBar: (Logdata.userEmail == "Ayush@gmail.com" ||
              Logdata.userEmail == "So@gmail.com" ||
              Logdata.userEmail == "Leyons@gmail.com" ||
              Logdata.userEmail == "Ocean@gmail.com" ||
              Logdata.userEmail == "Hela@gmail.com" ||
              Logdata.userEmail == "Finagle@gmail.com")
          ? AppBar(
              backgroundColor: Colors.teal,
              title: const Text(
                'Settings',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Canteen()),
                  );
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
            )
          : AppBar(
              backgroundColor: Colors.teal,
              title: const Text(
                'Settings',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[600],
        currentIndex: currentIndex,
        onTap: (index) {
          if (Logdata.userEmail == "Ayush@gmail.com" ||
              Logdata.userEmail == "So@gmail.com" ||
              Logdata.userEmail == "Leyons@gmail.com" ||
              Logdata.userEmail == "Ocean@gmail.com" ||
              Logdata.userEmail == "Hela@gmail.com" ||
              Logdata.userEmail == "Finagle@gmail.com" ||
              Logdata.userEmail == "ayushcafe2002@gmail.com") {
            // Canteen owner navigation
            if (index == 0) onHomeTap?.call();
            if (index == 1) onOrdersTap?.call();
            if (index == 2) onSettingTap?.call();
          } else {
            // Regular user navigation
            if (index == 0) onHomeTap?.call();
            if (index == 1) onOrdersTap?.call();
            if (index == 2) onFavoriteTap?.call();
            if (index == 3) onSettingTap?.call();
          }
        },
        items: navItems,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE082), Color(0xFFFFB300)], // Amber gradient
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white.withOpacity(0.9),
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Colors.teal),
                    title: const Text(
                      'My Account',
                      style: TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold),
                    ),
                    onTap: () async {
                      try {
                        var url = Uri.parse(
                          "http://192.168.195.67/Firebase/profile.php",
                        );
                        var response = await http.post(
                          url,
                          body: {'email': Logdata.userEmail},
                        );

                        if (response.statusCode == 200) {
                          log("Data loaded");
                          var data = jsonDecode(response.body);

                          if (data is Map<String, dynamic>) {
                            setState(() {
                              user.name = data['name'].toString();
                              user.email = data['email'].toString();
                              user.tel = data['contact'].toString();
                              if (data['image'] != null) {
                                user.imageBytes = base64Decode(data['image']);
                              }
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()),
                            );
                          } else {
                            log("Blank");
                          }
                        }
                      } catch (ex) {
                        log("Error fetching profile: $ex");
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white.withOpacity(0.9),
                  child: ListTile(
                    leading: const Icon(Icons.support, color: Colors.teal),
                    title: const Text(
                      'Customer Support',
                      style: TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerSupport()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white.withOpacity(0.9),
                  child: ListTile(
                    leading: const Icon(Icons.lock, color: Colors.teal),
                    title: const Text(
                      'Change Password',
                      style: TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white.withOpacity(0.9),
                  child: ListTile(
                    leading: const Icon(Icons.logout, color: Colors.teal),
                    title: const Text(
                      'Log Out',
                      style: TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold),
                    ),
                    onTap: () async {
                      user.email = "";
                      user.name = "";
                      user.tel = "";
                      Logdata.canteen = false;

                      try {
                        var url = Uri.parse(
                          "http://192.168.195.67/Firebase/emptycart.php",
                        );
                        var response = await http.post(
                          url,
                          body: {'email': Logdata.userEmail},
                        );

                        if (response.statusCode == 200) {
                          log("Cart Cleaned");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyApp()),
                            (route) => false,
                          );
                          Logdata.userEmail = "";
                        }
                      } catch (ex) {
                        log("Error fetching profile: $ex");
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white.withOpacity(0.9),
                  child: ListTile(
                    leading:
                        const Icon(Icons.delete_forever, color: Colors.red),
                    title: const Text(
                      'Delete Account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeleteRequest()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
