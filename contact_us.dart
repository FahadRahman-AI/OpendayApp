import 'package:flutter/material.dart';
import 'about_us.dart';
import 'what_to_do.dart';
import 'intro_screen.dart';
import 'pages_layout.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(

      title: 'Contact Us',
      body: Center(
        child: Text(
          'Insert Waffle Here',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}