import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'about_us.dart'; 
import 'registration.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // Method to handle login error
  void _error(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error!"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to handle login functionality
  Future<void> _login() async {
    String user = _userController.text.trim();
    String pass = _passController.text.trim();

    // Error handling
    if (user.isEmpty || pass.isEmpty) {
      _error('Please enter both a username and password');
      return;
    }

    // Send login data to PHP backend
    print("Username: $user, Password: $pass");
    var url = Uri.parse("http://192.168.0.161/Open_Day_App/login.php");
    try{
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': user,
        'password': pass,
      }),
    );


    // Check if response status code is 200 (OK)
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("Response: $responseData"); // Debugging response from server

      // Check if the response contains a 'success' key with value true
      if (responseData['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Welcome, $user'),
            duration: Duration(seconds: 2),
          ),
        );
        // Navigate to the next page after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AboutUs()),
        );
      } else {
        // If login is not successful, show an error message
        _error(responseData['message']);
      }
    } else {
      // If the status code is not 200, show an error message
      _error('Failed to connect to server. Status code: ${response.statusCode}');
    }
  } catch (e) {
  // If there is an exception (e.g., no internet connection), handle it
  _error('Error: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login / Register'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _userController,
              decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passController,
              decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
              obscureText: true, // Hide password input
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Log In'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
            ),
            SizedBox(height: 10),
            // Register button to navigate to Registration Page
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registration()),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}





