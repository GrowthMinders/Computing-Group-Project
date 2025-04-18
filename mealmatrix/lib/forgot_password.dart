// ignore_for_file: file_names, duplicate_ignore, use_build_context_synchronously

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
    RegExp regexmail = RegExp('^[A-Za-z0-9]{3,50}@(students.nsbm.ac.lk)\$');
    RegExp regexmailcanteen = RegExp('^[A-Za-z]{3,50}@(gmail.com)\$');
    if (controller1.text.isEmpty) {
      Fpdata.error++;
      Fpdata.errmessage = "Please enter email address";
    } else if (!regexmail.hasMatch(controller1.text) &&
        !regexmailcanteen.hasMatch(controller1.text)) {
      Fpdata.error++;
      Fpdata.errmessage = "Invalid email address";
    }
  }
}

// ignore: camel_case_types
class forgot_passwordState extends State<forgot_password> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            setState(() {
              Fpdata.email = "";
              controller1.text = "";
              Fpdata.error = 0;
              Fpdata.errmessage = "";
            });
          },
          child: Text(''),
        ),
      ),
      body: Align(
        child: Column(
          children: [
            if (Fpdata.errmessage.isNotEmpty)
              SizedBox(
                child: Text(
                  '* ${Fpdata.errmessage}',
                  style: TextStyle(
                    color: Color.fromARGB(119, 235, 17, 17),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            SizedBox(height: 20),
            Text(
              'Forgot Password',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 180),
            Text('Enter email address', style: TextStyle(fontSize: 15)),
            SizedBox(height: 40),
            SizedBox(
              width: 300,
              height: 45,
              child: TextField(
                onTap: () {
                  setState(() {
                    Fpdata.error = 0;
                    Fpdata.errmessage = "";
                  });
                },
                controller: controller1,
                decoration: InputDecoration(
                  filled: true, // Enable background color
                  fillColor: Color(0xffDDDDDD),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'ex: johnsmith@students.nsbm.ac.lk',
                  hintStyle: TextStyle(
                    color: Color(0xff888888),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Color(0xff3AB54B)),
                  foregroundColor: WidgetStateProperty.all(Color(0xFFFFFFFF)),
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
                        "http://192.168.177.67/Firebase/forgotgetmail.php",
                      );

                      var response = await http.post(
                        url,
                        body: {'email': Fpdata.email},
                      );
                      if (response.statusCode == 200) {
                        log("Success: Mail Sent");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                        setState(() {
                          controller1.text = "";
                          Fpdata.error = 0;
                          Fpdata.errmessage = "";
                        });
                      } else if (response.statusCode == 400) {
                        log("Failed: Account Found");
                      } else if (response.statusCode == 401) {
                        log("Failed: Account not found");
                        setState(() {
                          Fpdata.error++;
                          Fpdata.errmessage = "Account not found";
                        });
                      } else if (response.statusCode == 500) {
                        log("Failed: Mail Sending Failed");
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
                child: const Text('Send'),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
