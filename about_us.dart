import 'package:flutter/material.dart';
import 'pages_layout.dart';
import 'what_to_do.dart';
import 'contact_us.dart';
import 'intro_screen.dart';



class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(

      title: 'About Us',
      body: Center(
        child: Text(
          'Insert Waffle Here',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}