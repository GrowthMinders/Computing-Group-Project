// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  TermsAndConditionsState createState() => TermsAndConditionsState();
}

class TermsAndConditionsState extends State<TermsAndConditions> {
  final Color primaryColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FFF5),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Terms and Conditions',
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
                  Image.asset(
                    'lib/assets/images/Meal Matrix Logo.png',
                    height: 160,
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Welcome to Meal Matrix!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Sections
                  _buildSectionWithIcon(
                    icon: Icons.info_outline,
                    title: 'Introduction',
                    content:
                        'These Terms and Conditions ("Terms") govern your use of the Meal Matrix mobile application ("App"), operated by Meal Matrix Inc. By using the App, you agree to these Terms.',
                  ),
                  _buildSectionWithIcon(
                    icon: Icons.person_outline,
                    title: '1. Eligibility',
                    content:
                        'You must have legal capacity to agree to these Terms.',
                  ),
                  _buildSectionWithIcon(
                    icon: Icons.how_to_reg,
                    title: '2. Account Registration',
                    content:
                        '• Create an account to access features\n• Provide accurate information\n• Secure your credentials',
                  ),
                  _buildSectionWithIcon(
                    icon: Icons.shopping_cart,
                    title: '3. Ordering and Payments',
                    content:
                        '• Order from listed vendors\n• Prices may vary\n• Pay through the App\n• You’re responsible for applicable charges\n• We’re not liable for food quality/delivery',
                  ),
                  _buildSectionWithIcon(
                    icon: Icons.cancel,
                    title: '4. Cancellations and Refunds',
                    content:
                        '• Subject to vendor policies\n• Refunds handled by vendors\n• We may cancel orders if needed',
                  ),
                  _buildSectionWithIcon(
                    icon: Icons.gavel,
                    title: '5. User Conduct',
                    content:
                        '• No unlawful use\n• No impersonation\n• No interference with App\n• No harassment\n• No unauthorized access attempts',
                  ),
                  _buildSectionWithIcon(
                    icon: Icons.copyright,
                    title: '6. Intellectual Property',
                    content:
                        '• All content is owned by Meal Matrix\n• Protected by IP laws\n• Do not copy/distribute content',
                  ),
                  _buildSectionWithIcon(
                    icon: Icons.privacy_tip,
                    title: '7. Privacy',
                    content:
                        'Use of the app is governed by our Privacy Policy explaining personal data handling.',
                  ),
                  _buildSectionWithIcon(
                    icon: Icons.warning,
                    title: '8. Limitation of Liability',
                    content:
                        '• We’re not liable for indirect damages\n• Total liability is limited to your payments',
                  ),
                  _buildSectionWithIcon(
                    icon: Icons.exit_to_app,
                    title: '9. Termination',
                    content:
                        '• We can revoke access\n• You can delete your account anytime',
                  ),
                  _buildSectionWithIcon(
                    icon: Icons.edit,
                    title: '10. Changes to Terms',
                    content:
                        'We may update these Terms. Continued use means you accept any changes.',
                  ),
                  _buildSectionWithIcon(
                    icon: Icons.balance,
                    title: '11. Governing Law',
                    content:
                        '• Governed by laws of Sri Lanka\n• Disputes handled in local courts',
                  ),
                  _buildSectionWithIcon(
                    icon: Icons.contact_mail,
                    title: '12. Contact Us',
                    content:
                        'Meal Matrix Inc.\nEmail: support@mealmatrix.com\nPhone: (123) 456-7890\nAddress: 123 Food Street, Foodville',
                  ),

                  const SizedBox(height: 32),

                  Text(
                    'By using Meal Matrix, you accept these Terms and Conditions.',
                    style: TextStyle(color: Colors.grey[800], fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Thank you for choosing Meal Matrix!',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionWithIcon({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22, color: Colors.teal),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Text(
              content,
              style:
                  TextStyle(fontSize: 15, height: 1.4, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
