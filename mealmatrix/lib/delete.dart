// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:mealmatrix/main.dart';
import 'package:mealmatrix/Setting.dart';

class DeleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Delete());
  }
}

class Delete extends StatefulWidget {
  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  TextEditingController controller1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
        ),
        backgroundColor: Colors.green,
        title: Row(
          children: [
            const SizedBox(width: 10),
            Text(
              'Delete Confirmation',
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
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        'Prove Ownership',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Please enter your password to confirm this action',
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: controller1,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
                              padding: EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'CONFIRM',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              try {
                                var url = Uri.parse(
                                  "http://192.168.177.67/Firebase/accdelete.php",
                                );

                                var response = await http.post(
                                  url,
                                  body: {
                                    'email': Logdata.userEmail,
                                    'pass': controller1.text,
                                  },
                                );
                                if (response.statusCode == 200) {
                                  log("Success: Account Deleted");
                                  Logdata.userEmail = "";
                                  user.email = "";
                                  user.name = "";
                                  user.tel = "";
                                  Logdata.canteen = false;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => MyApp()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Failed to delete account. Please try again.',
                                      ),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                }
                              } catch (ex) {
                                log("Unexpected error: $ex");
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
