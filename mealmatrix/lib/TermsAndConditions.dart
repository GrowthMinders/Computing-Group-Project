// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  TermsAndConditionsState createState() => TermsAndConditionsState();
}

class TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  const Icon(Icons.assignment, size: 40, color: Colors.blue),
                  const SizedBox(height: 8),
                  const Text(
                    'Welcome to Meal Matrix!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionWithIcon(
              icon: Icons.info_outline,
              title: 'Introduction',
              content:
                  'These Terms and Conditions ("Terms") govern your use of the Meal Matrix mobile application ("App"), operated by Meal Matrix Inc. ("we," "us," or "our"). By downloading, accessing, or using the App, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use the App.',
            ),
            _buildSectionWithIcon(
              icon: Icons.person_outline,
              title: '1. Eligibility',
              content:
                  'By using the App, you represent and warrant that you have the legal capacity to enter into these Terms.',
            ),
            _buildSectionWithIcon(
              icon: Icons.how_to_reg,
              title: '2. Account Registration',
              content: '''
• You may need to create an account to access certain features
• You must provide accurate and complete information
• You are responsible for maintaining account security''',
            ),
            _buildSectionWithIcon(
              icon: Icons.shopping_cart,
              title: '3. Ordering and Payments',
              content: '''
• Place orders from participating restaurants
• Prices may change without notice
• Payment must be made through the App
• You're responsible for all fees and taxes
• We're not responsible for food quality or delivery''',
            ),
            _buildSectionWithIcon(
              icon: Icons.cancel,
              title: '4. Cancellations and Refunds',
              content: '''
• Cancellations subject to Vendor policies
• Refunds processed per Vendor policies
• We may cancel orders at our discretion''',
            ),
            _buildSectionWithIcon(
              icon: Icons.gavel,
              title: '5. User Conduct',
              content: '''
• Don't use the App unlawfully
• Don't impersonate others
• Don't interfere with App operations
• Don't harass or harm others
• Don't attempt unauthorized access''',
            ),
            _buildSectionWithIcon(
              icon: Icons.copyright,
              title: '6. Intellectual Property',
              content: '''
• App content is owned by Meal Matrix
• Protected by intellectual property laws
• No unauthorized copying or distribution''',
            ),
            _buildSectionWithIcon(
              icon: Icons.privacy_tip,
              title: '7. Privacy',
              content:
                  'Your use is subject to our Privacy Policy which explains how we handle your personal information.',
            ),
            _buildSectionWithIcon(
              icon: Icons.warning,
              title: '8. Limitation of Liability',
              content: '''
• We're not liable for indirect damages
• Total liability limited to what you paid''',
            ),
            _buildSectionWithIcon(
              icon: Icons.exit_to_app,
              title: '9. Termination',
              content: '''
• We may terminate access anytime
• You may delete your account anytime''',
            ),
            _buildSectionWithIcon(
              icon: Icons.edit,
              title: '10. Changes to Terms',
              content:
                  'We may update these Terms, and continued use means acceptance of changes.',
            ),
            _buildSectionWithIcon(
              icon: Icons.balance,
              title: '11. Governing Law',
              content: '''
• Governed by laws of [Jurisdiction]
• Disputes resolved in [Jurisdiction] courts''',
            ),
            _buildSectionWithIcon(
              icon: Icons.contact_mail,
              title: '12. Contact Us',
              content: '''
Meal Matrix Inc.
Email: support@mealmatrix.com
Phone: (123) 456-7890
Address: 123 Food Street, Foodville''',
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  const Icon(Icons.check_circle, size: 40, color: Colors.green),
                  const SizedBox(height: 8),
                  const Text(
                    'By using Meal Matrix, you acknowledge that you have read, understood, and agreed to these Terms and Conditions.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Thank you for choosing Meal Matrix!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
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
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Text(content, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
