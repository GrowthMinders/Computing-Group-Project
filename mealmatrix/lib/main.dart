// ignore_for_file: use_build_context_synchronously

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
    RegExp regexmailcanteen = RegExp('^[A-Za-z]{3,50}@(gmail.com)\$');

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
    return SizedBox(
      child: Text(
        '* ${Logdata.errmessage}',
        style: const TextStyle(
          color: Color.fromARGB(119, 235, 17, 17),
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  return const SizedBox.shrink();
}

class MyAppState extends State<MyApp> {
  bool isChecked = false;
  bool isHoveredLogin = false;
  bool isHoveredRegister = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  errors(),

                  Image.asset(
                    'lib/assets/images/Meal Matrix Logo.png',
                    height: 250,
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),

                  // Welcome Text
                  const Text(
                    'Welcome to Meal Matrix \n\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff228B22),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(
                    width: 300,
                    child: TextField(
                      onTap: () {
                        setState(() {
                          Logdata.error = 0;
                          Logdata.errmessage = "";
                          Logdata.canteen = false;
                        });
                      },
                      controller: controller1,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_2_outlined),
                        prefixIconColor: const Color(0xffA6A6A6),
                        hintText: 'Enter Email',
                        hintStyle: const TextStyle(
                          color: Color(0xffA6A6A6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: 300,
                    child: TextField(
                      onTap: () {
                        setState(() {
                          Logdata.error = 0;
                          Logdata.errmessage = "";
                          Logdata.canteen = false;
                        });
                      },
                      controller: controller2,
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        prefixIconColor: const Color(0xffA6A6A6),
                        hintText: 'Enter Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (obscureText == true) {
                                obscureText = false;
                              } else {
                                obscureText = true;
                              }
                            });
                          },
                          child: const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Color(0xff888888),
                          ),
                        ),
                        hintStyle: const TextStyle(
                          color: Color(0xffA6A6A6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200, // Adjusted width
                        child: CheckboxListTile(
                          value: isChecked,
                          title: const Text('Remember Password'),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => forgot_password(),
                            ),
                          );
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Login Button
                      MouseRegion(
                        onEnter: (_) => setState(() => isHoveredLogin = true),
                        onExit: (_) => setState(() => isHoveredLogin = false),
                        child: SizedBox(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                Logdata.email = controller1.text.trim();
                                Logdata.pass = controller2.text.trim();
                              });
                              Logdata.validate();
                              if (Logdata.error == 0) {
                                try {
                                  var url = Uri.parse(
                                    "http://192.168.177.67/Firebase/login.php",
                                  );

                                  var response = await http.post(
                                    url,
                                    body: {
                                      'email': Logdata.email,
                                      'pass': Logdata.pass,
                                    },
                                  );
                                  if (response.statusCode == 200) {
                                    log("Success: Login Succeeded");
                                    //Cart empting
                                    try {
                                      var url = Uri.parse(
                                        "http://192.168.177.67/Firebase/emptycart.php",
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
                                              builder: (context) =>
                                                  const MyApp()),
                                          (route) => false,
                                        );
                                      }
                                    } catch (ex) {
                                      log("Error fetching profile: $ex");
                                    }
                                    final Map<String, dynamic> responseData =
                                        jsonDecode(response.body);

                                    setState(() {
                                      Logdata.userEmail = responseData['user'];
                                    });
                                    if (Logdata.userEmail ==
                                        "Ayush@gmail.com") {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => Canteen(),
                                        ),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => Home(),
                                        ),
                                      );
                                    }

                                    setState(() {
                                      controller1.text = "";
                                      controller2.text = "";
                                      Regdata.email = "";
                                      Regdata.pass = "";
                                      Regdata.error = 0;
                                      Regdata.errmessage = "";
                                    });
                                  } else if (response.statusCode == 203) {
                                    log("Invalid Credentials");
                                    setState(() {
                                      Logdata.error++;
                                      Logdata.errmessage =
                                          "Invalid Credentials";
                                      Logdata.canteen = false;
                                    });
                                  } else if (response.statusCode == 204) {
                                    log("Account does not exist");
                                    setState(() {
                                      Logdata.error++;
                                      Logdata.errmessage =
                                          "Account does not exist";
                                      Logdata.canteen = false;
                                    });
                                  }
                                } catch (ex) {
                                  log("Unexpected error: $ex");
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                isHoveredLogin ? Colors.green : Colors.white,
                              ),
                              foregroundColor: WidgetStateProperty.all(
                                isHoveredLogin ? Colors.white : Colors.black,
                              ),
                            ),
                            child: const Text(
                              'Log in',
                              style: TextStyle(fontFamily: "Trebuchet MS"),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),

                      MouseRegion(
                        onEnter: (_) =>
                            setState(() => isHoveredRegister = true),
                        onExit: (_) =>
                            setState(() => isHoveredRegister = false),
                        child: SizedBox(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegistrationPage(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                isHoveredRegister ? Colors.green : Colors.white,
                              ),
                              foregroundColor: WidgetStateProperty.all(
                                isHoveredRegister ? Colors.white : Colors.black,
                              ),
                            ),
                            child: const Text('Register'),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  const Text('By signing you are agreeing to our'),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TermsAndConditions(),
                        ),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(color: Colors.blue),
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
