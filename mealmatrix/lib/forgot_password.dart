// ignore_for_file: file_names, use_build_context_synchronously, deprecated_member_use, camel_case_types, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'main.dart';

// ignore: camel_case_types
class forgot_password extends StatefulWidget {
  const forgot_password({Key? key}) : super(key: key);

  @override
  forgot_passwordState createState() => forgot_passwordState();
}

TextEditingController controller1 = TextEditingController();

class Fpdata {
  static String email = "";
  static int error = 0;
  static String errmessage = "";

  static void validate() {
    RegExp regexmail = RegExp(r'^[A-Za-z0-9]{3,50}@(students.nsbm.ac.lk)$');
    RegExp regexmailcanteen = RegExp(r'^[A-Za-z]{3,50}@(gmail.com)$');
    if (controller1.text.isEmpty) {
      error++;
      errmessage = "Please enter email address";
    } else if (!regexmail.hasMatch(controller1.text) &&
        !regexmailcanteen.hasMatch(controller1.text)) {
      error++;
      errmessage = "Invalid email address";
    }
  }
}

class forgot_passwordState extends State<forgot_password> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF5),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (Fpdata.errmessage.isNotEmpty)
              Text(
                '* ${Fpdata.errmessage}',
                style: TextStyle(
                  color: Colors.red.withOpacity(0.9),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 32),
            const Text(
              'Reset your password',
              style: TextStyle(
                color: Colors.teal,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Trebuchet MS',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Text(
              'Enter your email address below and we\'ll send you a link to reset your password.',
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onTap: () {
                  setState(() {
                    Fpdata.error = 0;
                    Fpdata.errmessage = "";
                  });
                },
                controller: controller1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'ex: johnsmith@students.nsbm.ac.lk',
                  hintStyle: TextStyle(
                    color: Colors.grey[500],
                  ),
                  prefixIcon:
                      const Icon(Icons.email_outlined, color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    Fpdata.email = controller1.text.trim();
                    Fpdata.error = 0;
                    Fpdata.errmessage = "";
                  });
                  Fpdata.validate();
                  if (Fpdata.error == 0) {
                    try {
                      var url = Uri.parse(
                          "http://192.168.195.67/Firebase/forgotgetmail.php");

                      var response = await http.post(
                        url,
                        body: {'email': Fpdata.email},
                      );

                      if (response.statusCode == 200) {
                        log("Success: Mail Sent");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp()),
                        );
                        setState(() {
                          controller1.clear();
                          Fpdata.error = 0;
                          Fpdata.errmessage = "";
                        });
                      } else if (response.statusCode == 401) {
                        setState(() {
                          Fpdata.error++;
                          Fpdata.errmessage = "Account not found";
                        });
                      } else if (response.statusCode == 500) {
                        setState(() {
                          Fpdata.error++;
                          Fpdata.errmessage = "Mail sending failed";
                        });
                      }
                    } catch (ex) {
                      log("Unexpected error: $ex");
                    }
                  }
                },
                child: const Text('Send Reset Link'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
