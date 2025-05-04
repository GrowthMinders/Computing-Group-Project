// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, file_names, unused_import, use_build_context_synchronously, await_only_futures

import 'package:flutter/material.dart';
import 'package:mealmatrix/Home.dart';
import 'package:mealmatrix/Setting.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:typed_data';
import 'package:mealmatrix/main.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  String? filePath;
  TextEditingController controller = TextEditingController();

  Future<void> pickMedia() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          filePath = result.files.first.path;
          controller.text = filePath ?? '';
        });

        var url =
            Uri.parse("http://192.168.195.67/Firebase/updateprofilepic.php");
        var request = http.MultipartRequest('POST', url);

        request.fields['email'] = Logdata.userEmail;

        if (filePath != null) {
          request.files.add(
            await http.MultipartFile.fromPath('image', filePath!),
          );
        }

        var response = await request.send();
        final responseData = await response.stream.bytesToString();

        if (response.statusCode == 200) {
          log("Success: Profile Picture Updated");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else {
          log("Failed with status: ${response.statusCode}, body: $responseData");
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to update: $responseData'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } catch (ex) {
      log("Error picking media: $ex");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${ex.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'My Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('lib/assets/images/Meal Matrix Logo.png'),
              radius: 20,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE082), Color(0xFFFFB300)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: user.imageBytes != null
                                  ? MemoryImage(user.imageBytes!)
                                  : const AssetImage(
                                          'lib/assets/images/DefaultProfile.png')
                                      as ImageProvider,
                              backgroundColor: Colors.white.withOpacity(0.9),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: pickMedia,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.teal[700],
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Colors.white.withOpacity(0.9),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildProfileItem(
                                icon: Icons.person,
                                title: 'Name',
                                value: user.name.isNotEmpty ? user.name : 'N/A',
                                isBold: true,
                              ),
                              const SizedBox(height: 16),
                              _buildProfileItem(
                                icon: Icons.email,
                                title: 'Email',
                                value:
                                    user.email.isNotEmpty ? user.email : 'N/A',
                              ),
                              const SizedBox(height: 16),
                              _buildProfileItem(
                                icon: Icons.lock,
                                title: 'Password',
                                value: '**********',
                              ),
                              const SizedBox(height: 16),
                              _buildProfileItem(
                                icon: Icons.phone,
                                title: 'Phone',
                                value: user.tel.isNotEmpty ? user.tel : 'N/A',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String value,
    bool isBold = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  color: isBold ? Colors.teal : Colors.grey[600],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
