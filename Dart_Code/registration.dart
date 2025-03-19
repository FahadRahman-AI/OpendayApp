import 'package:app1/intro_screen.dart';
import 'package:flutter/material.dart';
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
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        _selectedDateOfBirth = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }


  // Registration logic
  void _handleRegistration() {
    final fullName = _fullNameController.text;
    final email = _emailController.text;
    final contact = _contactController.text;
    final username = _usernameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Simple validation for matching passwords
    if (password != confirmPassword || password.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Passwords do not match!'),
      ));
      return;
      //Check username is not empty
    } else if (username == null || username
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Username cannot be empty!'),
      ));
      return;
      //Check Full name is not empty
    }else if (fullName == null || fullName
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Full Name cannot be empty!'),
      ));
      return;
      //Check Email is not empty
    }else if (email == null || email
        .trim()
        .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Email cannot be empty!'),
      ));
      return;
      //Check if Contact Number is empty and exclude letters
    }else if (contact == null || contact.trim().isEmpty || !RegExp(r'^[0-9]+$').hasMatch(contact)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Contact Number invalid! Must contain only numbers.'),
      ));
      return;
      //Check a date of birth has been selected
    }else if (_selectedDateOfBirth == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select your date of birth!'),
      ));
      return;
      //If all data is filled in, return to login page
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (context) => IntroScreen()));
    }
    // Print to show registration has worked, replace with database logic
    print('Full Name: $fullName');
    print('Email: $email');
    print('Contact Number: $contact');
    print('Date of Birth: $_selectedDateOfBirth');
    print('Username: $username');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Register',
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
                hintText: 'e.g. +1234567890',
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

