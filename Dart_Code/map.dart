import 'package:flutter/material.dart';
import 'pages_layout.dart';

class GettingAround extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Container(
        color: Colors.white, // Optional: Set background color
        child: Center(
          child: Image.asset(
            'images/map_wolverhampton.jpg', // Make sure the image is in your "assets" folder
            fit: BoxFit.cover,
          ),
        ),
      ), title: 'Getting Around Campus',
    );
  }
}
