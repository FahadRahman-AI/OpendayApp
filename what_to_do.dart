import 'package:flutter/material.dart';
import 'about_us.dart';
import 'contact_us.dart';
import 'intro_screen.dart';
import 'pages_layout.dart';

class WhatToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(

      title: 'What To Do',
      body: Center(
        child: Text(
          'Insert Waffle Here',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}