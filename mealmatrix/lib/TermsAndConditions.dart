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
      appBar: AppBar(title: const Text('Terms and Conditions')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Meal Matrix!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'These Terms and Conditions ("Terms") govern your use of the Meal Matrix mobile application ("App"), operated by Meal Matrix Inc. ("we," "us," or "our"). By downloading, accessing, or using the App, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use the App.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '1. Eligibility',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '1.1. By using the App, you represent and warrant that you have the legal capacity to enter into these Terms.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '2. Account Registration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '2.1. To access certain features of the App, you may need to create an account.\n'
              '2.2. You agree to provide accurate, current, and complete information during registration and to update such information as necessary.\n'
              '2.3. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '3. Ordering and Payments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '3.1. The App allows you to place orders for food and beverages from participating restaurants ("Vendors").\n'
              '3.2. Prices displayed on the App are subject to change without notice.\n'
              '3.3. Payment for orders must be made through the App using the available payment methods.\n'
              '3.4. You agree to pay all fees, taxes, and charges associated with your orders.\n'
              '3.5. Meal Matrix is not responsible for the quality, safety, or delivery of food provided by Vendors.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '4. Cancellations and Refunds',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '4.1. Cancellation of orders is subject to the policies of the respective Vendor.\n'
              '4.2. Refunds, if applicable, will be processed in accordance with the Vendor\'s policies and applicable laws.\n'
              '4.3. Meal Matrix reserves the right to cancel any order at its discretion.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '5. User Conduct',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '5.1. You agree not to use the App for any unlawful or prohibited purpose.\n'
              '5.2. You must not:\n'
              '   - Impersonate any person or entity.\n'
              '   - Interfere with the operation of the App.\n'
              '   - Use the App to harass, defame, or harm others.\n'
              '   - Attempt to gain unauthorized access to the App or its systems.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '6. Intellectual Property',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '6.1. The App and its content, including logos, designs, and software, are owned by Meal Matrix and protected by intellectual property laws.\n'
              '6.2. You may not copy, modify, distribute, or create derivative works of the App or its content without our prior written consent.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '7. Privacy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '7.1. Your use of the App is subject to our Privacy Policy, which explains how we collect, use, and protect your personal information.\n'
              '7.2. By using the App, you consent to the collection and use of your information as outlined in the Privacy Policy.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '8. Limitation of Liability',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '8.1. Meal Matrix is not liable for any indirect, incidental, or consequential damages arising from your use of the App.\n'
              '8.2. Our total liability to you for any claims related to the App is limited to the amount you paid (if any) for using the App.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '9. Termination',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '9.1. We reserve the right to suspend or terminate your access to the App at any time, with or without notice, for any reason.\n'
              '9.2. You may terminate your account at any time by contacting us or using the account deletion feature in the App.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '10. Changes to Terms',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '10.1. We may update these Terms from time to time. Any changes will be posted on the App, and your continued use of the App constitutes acceptance of the revised Terms.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '11. Governing Law',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '11.1. These Terms are governed by the laws of [Insert Jurisdiction], without regard to its conflict of law principles.\n'
              '11.2. Any disputes arising from these Terms or your use of the App will be resolved exclusively in the courts of [Insert Jurisdiction].',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              '12. Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'If you have any questions or concerns about these Terms, please contact us at:\n'
              'Meal Matrix Inc.\n'
              'Email: [Insert Email Address]\n'
              'Phone: [Insert Phone Number]\n'
              'Address: [Insert Physical Address]',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              'By using Meal Matrix, you acknowledge that you have read, understood, and agreed to these Terms and Conditions. Thank you for choosing Meal Matrix!',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
