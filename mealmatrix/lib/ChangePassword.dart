// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously, file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:mealmatrix/State/PasswordChangeSucess.dart';
import 'package:mealmatrix/main.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  bool _obscurePassword = true;
  String _errorMessage = "";

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final String pass = _newPassController.text.trim();
      final String email = Logdata.userEmail;

      try {
        var url = Uri.parse("http://192.168.1.16/Firebase/passwordchange.php");
        var response =
            await http.post(url, body: {'pass': pass, 'email': email});

        if (response.statusCode == 200) {
          log("Success: Password changed");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const PCSucess()));
        } else {
          setState(() {
            _errorMessage = "Server error. Please try again.";
          });
        }
      } catch (e) {
        log("Error: $e");
        setState(() {
          _errorMessage = "Unexpected error. Please check your connection.";
        });
      }
    }
  }

  String? _validatePassword(String? value) {
    final password = value ?? "";

    if (password.isEmpty) return "Please enter your password";
    if (!RegExp(r'[a-z]').hasMatch(password))
      return "Include at least one lowercase letter";
    if (!RegExp(r'[A-Z]').hasMatch(password))
      return "Include at least one uppercase letter";
    if (!RegExp(r'[0-9]').hasMatch(password))
      return "Include at least one digit";
    if (!RegExp(r'[~`!@#&<>/?";:{}|,]').hasMatch(password))
      return "Include at least one special character";
    if (password.length < 8 || password.length > 24)
      return "Password must be 8-24 characters";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE082), Color(0xFFFFB300)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxWidth: 500),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      const Center(
                        child: Text(
                          "Set a New Password",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "New Password",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _newPassController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: "At least 8 characters",
                          filled: true,
                          fillColor: Colors.grey[100],
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: _togglePasswordVisibility,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        validator: _validatePassword,
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        "Confirm Password",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _confirmPassController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: "Re-enter your new password",
                          filled: true,
                          fillColor: Colors.grey[100],
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: _togglePasswordVisibility,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        validator: (value) {
                          if (value != _newPassController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        child: const Text(
                          "Change Password",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
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
