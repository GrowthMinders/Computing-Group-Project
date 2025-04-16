// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:mealmatrix/delete.dart';
import 'package:mealmatrix/main.dart';

class DeleteConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DeleteConfirmation(),
    );
  }
}

class DeleteConfirmation extends StatefulWidget {
  @override
  _DeleteConfirmationState createState() => _DeleteConfirmationState();
}

class _DeleteConfirmationState extends State<DeleteConfirmation> {
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
                      title: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Enter "Delete ${Logdata.userEmail}"',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Text(
                        'Type the exact phrase to confirm account deletion',
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: controller1,
                      decoration: InputDecoration(
                        hintText: 'Enter the phrase above',
                        hintStyle: TextStyle(
                          color: Color(0xffA6A6A6),
                          fontWeight: FontWeight.bold,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        prefixIcon: Icon(Icons.email_outlined),
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
                            onPressed: () {
                              if (controller1.text ==
                                  "Delete ${Logdata.userEmail}") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Delete(),
                                  ),
                                );
                              } else {
                                controller1.text = "";
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Setting(),
                                  ),
                                );
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
