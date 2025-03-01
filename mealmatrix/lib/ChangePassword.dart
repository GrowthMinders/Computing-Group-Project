// ignore_for_file: file_names, non_constant_identifier_names, unused_field

import 'package:flutter/material.dart';
import 'package:mealmatrix/State/PasswordChangeSucess.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:mealmatrix/main.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: ChangePassword());
  }
}

TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  static String cpass = "";
  static String pass = "";
  static int error = 0;
  static String errmessage = "";

  void validate() {
    setState(() {
      error = 0;
      errmessage = "";

      RegExp regexpasssimple = RegExp('[a-z]+');
      RegExp regexpasscapital = RegExp('[A-Z]+');
      RegExp regexpassdigit = RegExp('[0-9]+');
      RegExp regexpassspecial = RegExp('[~`!@#&<>/?";:{}|,]+');
      RegExp regexpasslength = RegExp('^[a-zA-Z0-9~`!@#&<>/?";:{}|,]{8,24}\$');

      if (controller1.text.isEmpty) {
        error++;
        errmessage = "Please enter your password";
      } else if (controller2.text.isEmpty) {
        error++;
        errmessage = "Please enter the same password again";
      } else if (!regexpasssimple.hasMatch(controller1.text)) {
        error++;
        errmessage = "Password should consist of at least one simple character";
      } else if (!regexpasscapital.hasMatch(controller1.text)) {
        error++;
        errmessage = "Password should consist of at least one capital letter";
      } else if (!regexpassdigit.hasMatch(controller1.text)) {
        error++;
        errmessage = "Password should consist of at least one digit";
      } else if (!regexpassspecial.hasMatch(controller1.text)) {
        error++;
        errmessage =
            "Password should consist of at least one special character";
      } else if (!regexpasslength.hasMatch(controller1.text)) {
        error++;
        errmessage = "Password should consist of length 8 - 24";
      } else if (controller1.text != controller2.text) {
        error++;
        errmessage = "Passwords do not match";
      }
    });
  }

  Widget errors() {
    if (errmessage.isNotEmpty) {
      return SizedBox(
        child: Text(
          '* $errmessage',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              errors(),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                  child: Text(
                    "New Password",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text("Enter New Password"),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    onTap: () {
                      setState(() {
                        error = 0;
                        errmessage = "";
                      });
                    },
                    controller: controller1,
                    decoration: InputDecoration(
                      hintText: "At least 8 characters",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    obscureText: true,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(bottom: 130),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text("Confirm New Password"),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      onTap: () {
                        setState(() {
                          error = 0;
                          errmessage = "";
                        });
                      },
                      controller: controller2,
                      decoration: InputDecoration(
                        hintText: "Re-enter new password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      validate();
                      if (error == 0 && errmessage == "") {
                        pass = controller1.text.trim();
                        cpass = controller2.text.trim();

                        try {
                          var url = Uri.parse(
                            "http://192.168.72.67/Firebase/passwordchange.php",
                          );

                          var response = await http.post(
                            url,
                            body: {'pass': pass, 'email': Logdata.userEmail},
                          );
                          if (response.statusCode == 200) {
                            log("Success: Password changed");
                            Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) => PCSucess(),
                              ),
                            );
                            setState(() {
                              controller1.text = "";
                              controller2.text = "";
                              error = 0;
                              errmessage = "";
                            });
                          }
                        } catch (ex) {
                          log("Unexpected error: $ex");
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
