import 'package:flutter/material.dart';
import 'intro_screen.dart';
import 'pages_layout.dart';

//Create the registration page with name, dob and gender

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // Controllers for text fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Date of birth field
  String? _selectedDateOfBirth;

  // Date picker method
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // Default to year 2000
      firstDate: DateTime(1900),   // Allow old dates
      lastDate: DateTime.now(),    // Prevent future dates
    );

    if (picked != null) {
      setState(() {
        _selectedDateOfBirth = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  // Function to register user
  void _handleRegistration() async {
    // Extract input values
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final contact = _contactController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validation
    if (fullName.isEmpty) {
      _showSnackbar('Full Name cannot be empty!');
      return;
    }
    if (email.isEmpty || !email.contains('@')) {
      _showSnackbar('Invalid Email!');
      return;
    }
    if (contact.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(contact)) {
      _showSnackbar('Contact Number must contain only numbers!');
      return;
    }
    if (_selectedDateOfBirth == null) {
      _showSnackbar('Please select your date of birth!');
      return;
    }
    if (username.isEmpty) {
      _showSnackbar('Username cannot be empty!');
      return;
    }
    if (password.isEmpty || password.length < 6) {
      _showSnackbar('Password must be at least 6 characters long!');
      return;
    }
    if (password != confirmPassword) {
      _showSnackbar('Passwords do not match!');
      return;
    }

    // API URL local ip address for emulator to use
    final url = Uri.parse('http://192.168.0.161/Open_Day_App/register.php');

    try {
      // Send POST request to PHP API
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'full_name': fullName,
          'email': email,
          'contact_number': contact,
          'dob': _selectedDateOfBirth,
          'username': username,
          'password': password,
        }),
      );
      //DEBUG (given by chatGPT)
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // Handle success
      } else {
        // Handle error
      }

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['success'] == true) {
        _showSnackbar('Registration successful!');

        // Navigate to the Intro Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
        );
      } else {
        _showSnackbar(responseData['message'] ?? 'Registration failed!');
      }
    } catch (error) {
      _showSnackbar('Error: Could not connect to the server!');
    }
  }

  // Helper function to show Snackbar messages
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Register",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Full Name
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
              ),
            ),
            SizedBox(height: 10),

            // Email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'example@domain.com',
              ),
            ),
            SizedBox(height: 10),

            // Contact Number
            TextField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: 'Contact Number',
                hintText: 'e.g. 07549876343',
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),

            // Date of Birth
            Row(
              children: [
                Text('Date of Birth: ', style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(_selectedDateOfBirth ?? 'Select Date'),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Username
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 10),

            // Password
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true, // Mask the password text
            ),
            SizedBox(height: 10),

            // Confirm Password
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
              ),
              obscureText: true, // Mask the confirm password text
            ),
            SizedBox(height: 20),

            // Register Button
            ElevatedButton(
              onPressed: _handleRegistration,
              child: Text('Register'),
            ),
          ],
        ),
      ),
      showMenu: false,
    );
  }
}
