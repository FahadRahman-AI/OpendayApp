import 'package:flutter/material.dart';
import 'about_us.dart';
import 'registration.dart';

///This page is a Stateful Widget as it will be edited by user text and we want
///to capture that text and at some point insert it into our database.
///So far information requested on the register page is Name, DOB, Gender
///
class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>{

//Read and return text input for username and password fields
final TextEditingController _userController = TextEditingController();
final TextEditingController _passController = TextEditingController();

//Method for error handling, individual messages for different errors
void _error(String message){
  showDialog(context: context, builder: (BuildContext context){
    return AlertDialog(
      title: Text("Error!"),
      content: Text(message), 
      actions: <Widget>[
        TextButton(
          child: Text('Close'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
  );
  }

// Async login method to run log in code without disturbing the app
  Future<void> _login() async {
    String user = _userController.text.trim();
    String pass = _passController.text.trim();

    // Debug: Print the username and password to see what is entered
    print('Username: $user');
    print('Password: $pass');

    if (user.isNotEmpty && pass.isNotEmpty) {
      final url = Uri.parse('http://192.168.0.161/Open_Day_App/login.php'); // Update with your actual server URL

      try {
        // Send a POST request with the correct body format
        final response = await http.post(url, body: {
          'username': user,
          'password': pass,
        });

        //Debug check what was received from the API
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          try {
            var jsonResponse = json.decode(response.body);

            if (jsonResponse['success'] == true) {
              // Login successful
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Login successful! Welcome, $user!'),
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUs()), // Navigate to About Us page
              );
            } else {
              // Invalid credentials or another error
              _error(jsonResponse['message']);
            }
          } catch (e) {
            // If the response cannot be parsed into JSON
            print('Error parsing response: $e');
            _error('Error parsing server response');
          }
        } else {
          // If the server returns a non-200 status code
          _error('Server error: ${response.statusCode}');
        }
      } catch (e) {
        // Handle connection issues
        print('Error sending request: $e');
        _error('Failed to connect to the server');
      }
    } else {
      _error('Please enter both username and password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login / Register'), backgroundColor: Colors.blueGrey),
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
            ///Again, somewhat stuck with what to do here, obviously we want
            ///login to take us to the next page but until the logic above is
            ///done I don't just want the button to navigate to main page
            ///if you want to set it to navigate to next page just to check
            ///the rest of the app though feel free
            ElevatedButton(
              onPressed: _login,
              child: Text('Log In'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
            ),
            SizedBox(height: 10),
            //Register button with navigate to Registration Page
            OutlinedButton(
              onPressed: (){
                //Go to register page
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





