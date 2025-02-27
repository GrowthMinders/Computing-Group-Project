// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'main.dart';
import 'TermsAndConditions.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();
TextEditingController controller3 = TextEditingController();
TextEditingController controller4 = TextEditingController();
TextEditingController controller5 = TextEditingController();

class Regdata {
  static String name = "";
  static String email = "";
  static String phone = "";
  static String pass = "";
  static String cpass = "";
  static int error = 0;
  static String errmessage = "";
  static bool isChecked = false;

  static void validate() {
    error = 0;
    errmessage = "";

    RegExp regexname = RegExp(
      // ignore: unnecessary_string_escapes
      r'^[A-Za-z\s]{3,150}$',
    );
    RegExp regexmail = RegExp('^[A-Za-z0-9]{3,50}@(students.nsbm.ac.lk)\$');
    RegExp regexphone = RegExp(
      '^((074|076|078|075|071|070|072)[0-9]{7})|(0777)[0-9]{6}\$',
    );
    RegExp regexpasssimple = RegExp('[a-z]+');
    RegExp regexpasscapital = RegExp('[A-Z]+');
    RegExp regexpassdigit = RegExp('[0-9]+');
    RegExp regexpassspecial = RegExp('[~`!@#&<>/?";:{}|,]+');
    RegExp regexpasslength = RegExp(
      // ignore: unnecessary_string_escapes
      '^[a-zA-Z0-9~`!@#&<>/?";:{}|,]{8,24}\$',
    );

    if (controller1.text.isEmpty) {
      Regdata.error++;
      Regdata.errmessage = "Please enter your name";
    } else if (!regexname.hasMatch(Regdata.name)) {
      Regdata.error++;
      Regdata.errmessage = "Please enter a valid name";
    } else if (controller2.text.isEmpty) {
      Regdata.error++;
      Regdata.errmessage = "Please enter your email";
    } else if (!regexmail.hasMatch(Regdata.email)) {
      Regdata.error++;
      Regdata.errmessage = "Please enter a valid email";
    } else if (controller3.text.isEmpty) {
      Regdata.error++;
      Regdata.errmessage = "Please enter your telephone number";
    } else if (!regexphone.hasMatch(Regdata.phone)) {
      Regdata.error++;
      Regdata.errmessage = "Please enter a valid phone number";
    } else if (controller4.text.isEmpty) {
      Regdata.error++;
      Regdata.errmessage = "Please enter a password";
    } else if (!regexpasssimple.hasMatch(Regdata.pass)) {
      Regdata.error++;
      Regdata.errmessage =
          "Password should consist of at least one simple character";
    } else if (!regexpasscapital.hasMatch(Regdata.pass)) {
      Regdata.error++;
      Regdata.errmessage =
          "Password should consist of at least one capital character";
    } else if (!regexpassdigit.hasMatch(Regdata.pass)) {
      Regdata.error++;
      Regdata.errmessage = "Password should consist of at least one digit";
    } else if (!regexpassspecial.hasMatch(Regdata.pass)) {
      Regdata.error++;
      Regdata.errmessage =
          "Password should consist of at least one special character";
    } else if (!regexpasslength.hasMatch(Regdata.pass)) {
      Regdata.error++;
      Regdata.errmessage = "Password should consist of length 8 - 24 ";
    } else if (controller5.text.isEmpty) {
      Regdata.error++;
      Regdata.errmessage = "Please confirm your password";
    } else if (controller5.text != controller4.text) {
      Regdata.error++;
      Regdata.errmessage = "Passwords do not match";
    } else if (!isChecked) {
      Regdata.error++;
      Regdata.errmessage = "Please agree to Terms and Conditions";
    }
  }
}

class RegistrationPageState extends State<RegistrationPage> {
  bool obscureText = true;
  bool obscureTextc = true;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            'lib/assets/images/Meal Matrix Logo.png',
            height: 80,
            width: 80,
            fit: BoxFit.contain,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (Regdata.errmessage.isNotEmpty)
                  SizedBox(
                    child: Text(
                      '* ${Regdata.errmessage}',
                      style: TextStyle(
                        color: Color.fromARGB(119, 235, 17, 17),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),

                const Text(
                  'Create your account',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 20),

                // Name Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 45.0),
                    child: const Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff6F6F6F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: TextField(
                    onTap: () {
                      setState(() {
                        Regdata.error = 0;
                        Regdata.errmessage = "";
                      });
                    },
                    controller: controller1, //Text gain
                    decoration: InputDecoration(
                      filled: true, // Enable background color
                      fillColor: Color(0xffDDDDDD),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'ex: john smith',
                      hintStyle: TextStyle(color: Color(0xff888888)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Email Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 45.0,
                    ), // Correct placement of padding
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff6F6F6F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: TextField(
                    onTap: () {
                      setState(() {
                        Regdata.error = 0;
                        Regdata.errmessage = "";
                      });
                    },
                    controller: controller2,
                    decoration: InputDecoration(
                      filled: true, // Enable background color
                      fillColor: Color(0xffDDDDDD),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'ex: johnsmith@students.nsbm.ac.lk',
                      hintStyle: const TextStyle(color: Color(0xff888888)),
                    ),
                  ),
                ),
                // Phone Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 45.0,
                    ), // Correct placement of padding
                    child: Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff6F6F6F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: TextField(
                    onTap: () {
                      setState(() {
                        Regdata.error = 0;
                        Regdata.errmessage = "";
                      });
                    },
                    controller: controller3,
                    decoration: InputDecoration(
                      filled: true, // Enable background color
                      fillColor: Color(0xffDDDDDD),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: '0761111567',
                      hintStyle: const TextStyle(color: Color(0xff888888)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Password Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 45.0,
                    ), // Correct placement of padding
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff6F6F6F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: TextField(
                    onTap: () {
                      setState(() {
                        Regdata.error = 0;
                        Regdata.errmessage = "";
                      });
                    },
                    controller: controller4,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      filled: true, // Enable background color
                      fillColor: Color(0xffDDDDDD),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                      hintText: 'Abcd@123',
                      hintStyle: const TextStyle(color: Color(0xff888888)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Confirm Password Field
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 45.0,
                    ), // Correct placement of padding
                    child: Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff6F6F6F),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: TextField(
                    onTap: () {
                      setState(() {
                        Regdata.error = 0;
                        Regdata.errmessage = "";
                      });
                    },
                    controller: controller5,
                    obscureText: obscureTextc,
                    decoration: InputDecoration(
                      filled: true, // Enable background color
                      fillColor: Color(0xffDDDDDD),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (obscureTextc == true) {
                              obscureTextc = false;
                            } else {
                              obscureTextc = true;
                            }
                          });
                        },
                        child: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Color(0xff888888),
                        ),
                      ),
                      hintText: 'Abcd@123',
                      hintStyle: const TextStyle(color: Color(0xff888888)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Checkbox for Terms & Policy
                SizedBox(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                    ), // Apply padding here
                    child: CheckboxListTile(
                      value: Regdata.isChecked,
                      title: Row(
                        children: [
                          Text('I understood the '),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Regdata.error = 0;
                                Regdata.errmessage = "";
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TermsAndConditions(),
                                ),
                              );
                            },
                            child: Text(
                              'terms & policy',
                              style: TextStyle(color: Color(0xff0386D0)),
                            ),
                          ),
                          Text('.'),
                        ],
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (value) {
                        setState(() {
                          Regdata.isChecked = value ?? false;
                        });
                      },
                    ),
                  ),
                ),

                // Login Buttonconst
                SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Color(0xff3AB54B),
                      ),
                      foregroundColor: WidgetStateProperty.all(
                        Color(0xFFFFFFFF),
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        Regdata.name = controller1.text.trim();
                        Regdata.email = controller2.text.trim();
                        Regdata.phone = controller3.text.trim();
                        Regdata.pass = controller4.text.trim();
                        Regdata.cpass = controller5.text.trim();
                      });
                      Regdata.validate();

                      if (Regdata.error == 0) {
                        try {
                          var url = Uri.parse(
                            "http://192.168.72.67/Firebase/register.php",
                          );

                          var response = await http.post(
                            url,
                            body: {
                              'name': Regdata.name,
                              'email': Regdata.email,
                              'phone': Regdata.phone,
                              'pass': Regdata.pass,
                            },
                          );
                          if (response.statusCode == 200) {
                            log("Success: Registartion Suceeded");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                            setState(() {
                              controller1.text = "";
                              controller2.text = "";
                              controller3.text = "";
                              controller4.text = "";
                              controller5.text = "";
                              Regdata.name = "";
                              Regdata.email = "";
                              Regdata.phone = "";
                              Regdata.pass = "";
                              Regdata.cpass = "";
                              Regdata.error = 0;
                              Regdata.errmessage = "";
                              Regdata.isChecked = false;
                            });
                          } else if (response.statusCode == 409) {
                            log("Contact number already registered");
                            setState(() {
                              Regdata.error++;
                              Regdata.errmessage =
                                  "Contact number already registered";
                            });
                          } else if (response.statusCode == 204) {
                            log("Email already registered");
                            setState(() {
                              Regdata.error++;
                              Regdata.errmessage = "Email already registered";
                            });
                          }
                        } catch (ex) {
                          log("Unexpected error: $ex");
                        }
                      }
                    },
                    child: const Text('SIGN UP'),
                  ),
                ),
                const SizedBox(height: 30),

                // Sign In Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: const Text(
                        'Have an account? ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          controller1.text = "";
                          controller2.text = "";
                          controller3.text = "";
                          controller4.text = "";
                          controller5.text = "";
                          Regdata.error = 0;
                          Regdata.errmessage = "";
                          Regdata.isChecked = false;
                        });

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 45.0),
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(fontSize: 20.5, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40), // Extra space at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
