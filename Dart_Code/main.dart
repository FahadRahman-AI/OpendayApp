import 'package:flutter/material.dart';
import 'intro_screen.dart';
import 'pages_layout.dart';


//This runs the app
void main() {
  runApp(MaterialApp(
      home: Home(),
  ));
}
//The code below sets out the home screen with logo and on touch entry to app.
  class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return BaseScaffold(

      title: 'University of Wolverhampton',
    body: Container(
      color: Colors.white,  // Set the body background color to white
      child: Center(
        //Button for entry to IntroScreen (Which is now a login/register screen)
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IntroScreen()),
            );
          },
          //Set styling for button to encapsulate logo
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.zero,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.all(10),
            minimumSize: Size(50, 50),
            fixedSize: Size(375, 300),
          ),
          //Insert the university logo
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'images/uni_wolverhampton.jpg',
                width: 350,
                height: 250,
              ),
              SizedBox(height: 0),
              Text(
                'Touch logo to enter',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    //No menu or back button required here
    showMenu: false,
  );
  }
}




