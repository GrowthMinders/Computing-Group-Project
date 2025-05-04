// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:mealmatrix/CanteenOwner.dart';
import 'RegistrationPage.dart';
import 'TermsAndConditions.dart';
import 'forgot_password.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();

RegExp regexmailcanteen = RegExp('^[A-Za-z]{2,50}@(gmail.com)\$');

class Logdata {
  static String email = "";
  static String pass = "";
  static int error = 0;
  static String errmessage = "";
  static String userEmail = "";
  static bool canteen = false;

  static void validate() {
    error = 0;
    errmessage = "";

    RegExp regexmail = RegExp('^[A-Za-z]{3,50}@(students.nsbm.ac.lk)\$');

    if (controller1.text.isEmpty) {
      Logdata.error++;
      Logdata.errmessage = "Please enter your email";
    } else if (controller2.text.isEmpty) {
      Logdata.error++;
      Logdata.errmessage = "Please enter your password";
    } else if (!regexmail.hasMatch(controller1.text) &&
        !regexmailcanteen.hasMatch(controller1.text)) {
      Logdata.error++;
      Logdata.errmessage = "Invalid email address";
    } else if (regexmailcanteen.hasMatch(controller1.text)) {
      canteen = true;
    }
  }
}

Widget errors() {
  if (Logdata.errmessage.isNotEmpty) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        '* ${Logdata.errmessage}',
        style: TextStyle(
          color: Colors.red.withOpacity(0.9),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  return const SizedBox.shrink();
}

class MyAppState extends State<MyApp> {
  bool isChecked = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  errors(),
                  Image.asset(
                    'lib/assets/images/Meal Matrix Logo.png',
                    height: 160,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Welcome to Meal Matrix',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
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
                      controller: controller1,
                      onTap: () => setState(() {
                        Logdata.error = 0;
                        Logdata.errmessage = "";
                        Logdata.canteen = false;
                      }),
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        prefixIcon: const Icon(Icons.person_outline,
                            color: Colors.teal),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
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
                      controller: controller2,
                      obscureText: obscureText,
                      onTap: () => setState(() {
                        Logdata.error = 0;
                        Logdata.errmessage = "";
                        Logdata.canteen = false;
                      }),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon:
                            const Icon(Icons.lock_outline, color: Colors.teal),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.teal,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.teal),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        activeColor: Colors.teal,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                      ),
                      Text(
                        'Remember Me',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => forgot_password()),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.teal),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black.withOpacity(0.2),
                        backgroundColor: Colors.teal[700],
                      ),
                      child: const Center(
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          Logdata.email = controller1.text.trim();
                          Logdata.pass = controller2.text.trim();
                        });

                        Logdata.validate();
                        if (Logdata.error == 0) {
                          try {
                            var url = Uri.parse(
                                "http://192.168.195.67/Firebase/login.php");
                            var response = await http.post(url, body: {
                              'email': Logdata.email,
                              'pass': Logdata.pass,
                            });

                            if (response.statusCode == 200) {
                              final Map<String, dynamic> responseData =
                                  jsonDecode(response.body);
                              Logdata.userEmail = responseData['user'];

                              await http.post(
                                Uri.parse(
                                    "http://192.168.195.67/Firebase/emptycart.php"),
                                body: {'email': Logdata.userEmail},
                              );

                              if (regexmailcanteen
                                  .hasMatch(Logdata.userEmail)) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Canteen()));
                              } else {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) => Home()));
                              }

                              controller1.clear();
                              controller2.clear();
                            } else if (response.statusCode == 203) {
                              setState(() {
                                Logdata.error++;
                                Logdata.errmessage = "Invalid Credentials";
                              });
                            } else if (response.statusCode == 204) {
                              setState(() {
                                Logdata.error++;
                                Logdata.errmessage = "Account does not exist";
                              });
                            }
                          } catch (ex) {
                            log("Error: $ex");
                          }
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 300,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        side: const BorderSide(color: Colors.teal),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RegistrationPage()),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'By signing in you agree to our',
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TermsAndConditions()),
                      );
                    },
                    child: const Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
