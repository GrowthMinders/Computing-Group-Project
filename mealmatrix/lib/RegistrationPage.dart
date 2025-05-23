// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, use_build_context_synchronously, unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'main.dart';
import 'TermsAndConditions.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:file_picker/file_picker.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();
TextEditingController controller3 = TextEditingController();
TextEditingController controller4 = TextEditingController();
TextEditingController controller5 = TextEditingController();
TextEditingController controller6 = TextEditingController();

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
  String? filePath;
  bool obscureText = true;
  bool obscureTextc = true;
  TextEditingController controller = TextEditingController();

  void pickMedia() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
        controller6.text = filePath ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Registration',
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
              backgroundImage: AssetImage(
                'lib/assets/images/Meal Matrix Logo.png',
              ),
              radius: 25,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF7FFF5),
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    kToolbarHeight -
                    MediaQuery.of(context).padding.top,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (Regdata.errmessage.isNotEmpty)
                        SizedBox(
                          child: Text(
                            '* ${Regdata.errmessage}',
                            style: TextStyle(
                              color: Colors.red.withOpacity(0.9),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const SizedBox(height: 40),

                      const Text(
                        'Create your account',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Name Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                              Regdata.error = 0;
                              Regdata.errmessage = "";
                            });
                          },
                          controller: controller1,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.teal),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'ex: AAA Silva',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Email Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                              Regdata.error = 0;
                              Regdata.errmessage = "";
                            });
                          },
                          controller: controller2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.teal),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'ex: johnsmith@students.nsbm.ac.lk',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Phone Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            'Phone',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                              Regdata.error = 0;
                              Regdata.errmessage = "";
                            });
                          },
                          controller: controller3,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.teal),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: '0761111567',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Password Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                              Regdata.error = 0;
                              Regdata.errmessage = "";
                            });
                          },
                          controller: controller4,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.teal),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              child: const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.teal,
                              ),
                            ),
                            hintText: 'Abcd@123',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Confirm Password Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            'Confirm Password',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                              Regdata.error = 0;
                              Regdata.errmessage = "";
                            });
                          },
                          controller: controller5,
                          obscureText: obscureTextc,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.teal),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscureTextc = !obscureTextc;
                                });
                              },
                              child: const Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.teal,
                              ),
                            ),
                            hintText: 'Abcd@123',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Profile Picture Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            'Profile Picture',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            setState(() {
                              Regdata.error = 0;
                              Regdata.errmessage = "";
                            });
                          },
                          controller: controller6,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.teal),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Choose profile picture',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            suffixIcon: IconButton(
                              onPressed: pickMedia,
                              icon: const Icon(
                                Icons.file_upload,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Checkbox for Terms & Policy
                      SizedBox(
                        width: 400,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: CheckboxListTile(
                            value: Regdata.isChecked,
                            activeColor: Colors.teal,
                            title: Row(
                              children: [
                                Text(
                                  'I understood the ',
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      Regdata.error = 0;
                                      Regdata.errmessage = "";
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TermsAndConditions(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'terms & policy',
                                    style: TextStyle(color: Colors.teal),
                                  ),
                                ),
                                Text(
                                  '.',
                                  style: TextStyle(color: Colors.grey[800]),
                                ),
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
                      const SizedBox(height: 40),

                      // Sign Up Button
                      SizedBox(
                        width: 350,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            shadowColor: Colors.black.withOpacity(0.2),
                            backgroundColor: Colors.transparent,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.teal[600]!, Colors.teal[800]!],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                                  "http://192.168.195.67/Firebase/register.php",
                                );
                                var request =
                                    http.MultipartRequest('POST', url);

                                // Add text fields
                                request.fields['name'] = Regdata.name;
                                request.fields['email'] = Regdata.email;
                                request.fields['phone'] = Regdata.phone;
                                request.fields['pass'] = Regdata.pass;

                                // Add image file
                                if (filePath != null) {
                                  var file = await http.MultipartFile.fromPath(
                                    'image',
                                    filePath.toString(),
                                  );
                                  request.files.add(file);
                                }

                                var response = await request.send();
                                final responseData =
                                    await response.stream.bytesToString();

                                if (response.statusCode == 200) {
                                  log("Success: Registration Succeeded");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()),
                                  );
                                  // Reset fields...
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
                                    Regdata.errmessage =
                                        "Email already registered";
                                  });
                                }
                              } catch (ex) {
                                log("Unexpected error: $ex");
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Sign In Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Text(
                              'Have an account? ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
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
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: const Text(
                                'SIGN IN',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
