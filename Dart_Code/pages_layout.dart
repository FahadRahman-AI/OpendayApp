import 'package:flutter/material.dart';
import 'about_us.dart';
import 'contact_us.dart';
import 'what_to_do.dart';
import 'intro_screen.dart';


///The following code outlines the basic page layout used across all pages.
///This was what was originally on all pages and now can be called by referencing BaseScaffold to
///minimise repeated code as much as possible. The 'final' variables below are all required for
///BaseScaffold to be called, I've added a title to each app bar, the body for the page below,
///choice for menu button to be shown as it is not always required. Finally the leading section
///below I have used to remove the automatic back button that appears on the login/register page.
///Removed as a return button there doesn't really take you anywhere.

class BaseScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool showMenu; // New parameter to control menu visibility
  final Widget? leading; //Leading refers to beginning of app bar, '?' signifies it can be null
  final bool automaticallyImplyLeading; //Parameter to control back button

  const BaseScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.showMenu = true, // Default value: true (menu is shown by default)
    this.automaticallyImplyLeading = false,
    this.leading,
  }) : super(key: key);

  //Set a function to move around the app on menu button
  void _navigate(BuildContext context, String newValue) {
    if (newValue == 'About Us') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
    } else if (newValue == 'Contact Us') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs()));
    } else if (newValue == 'What To Do') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => WhatToDo()));
    } else if (newValue == 'Introduction') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => IntroScreen()));
    } //else if (newValue == 'QR Scan'){
      //Navigator.push(context, MaterialPageRoute(builder: (context) => QRScanPage()));
    //}
  }

  //Create the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueGrey,
        automaticallyImplyLeading: automaticallyImplyLeading, //Remove back button
        leading: showMenu // Check if menu should be displayed, show it can be null
            ? PopupMenuButton<String>(
          icon: Icon(Icons.menu, color: Colors.black),
          onSelected: (String newValue) => _navigate(context, newValue),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem(value: 'About Us', child: Text('About Us')),
            PopupMenuItem(value: 'Contact Us', child: Text('Contact Us')),
            PopupMenuItem(value: 'What To Do', child: Text('What To Do')),
            PopupMenuItem(value: 'Introduction', child: Text('Introduction')),
            //PopupMenuItem(value: 'QR Scan', child: Text('Qr Scan')),
          ],
        )
            : null, // If showMenu is false, remove the leading widget, ternary operator.
      ),
      body: body,
    );
  }
}