import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  String? _selectedDateOfBirth;

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDateOfBirth = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _handleRegistration() async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final contact = _contactController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Passwords do not match!'),
      ));
      return;
    }

    if (username.isEmpty || fullName.isEmpty || email.isEmpty || contact.isEmpty || _selectedDateOfBirth == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('All fields are required'),
      ));
      return;
    }

    var url = Uri.parse("http://192.168.0.161/Open_Day_App/register.php");

    try {
      var response = await http.post(
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

      print("Server response: ${response.body}");

      var responseJson = json.decode(response.body);
      print('Raw success value: ${responseJson['success']}');

      if (responseJson['success'] == true || responseJson['success'].toString().toLowerCase() == 'true') {
        print('Saving user data...');
        final prefs = await SharedPreferences.getInstance();

        print('Email: $email');
        print('DOB: $_selectedDateOfBirth');
        print('Contact: $contact');
        print('Password: $password');

        await prefs.setString('email', email);
        await secureStorage.write(key: 'password', value: password);
        await prefs.setString('dob', _selectedDateOfBirth!);
        await prefs.setString('contact', contact);

        print('Data saved successfully. Navigating to IntroScreen...');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => IntroScreen()),
        );
      } else {
        print('Registration failed with message: ${responseJson['message']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseJson['message'] ?? 'Registration failed')),
        );
      }
    } catch (e) {
      print('Error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(controller: _fullNameController, decoration: InputDecoration(labelText: 'Full Name')),
            SizedBox(height: 10),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            SizedBox(height: 10),
            TextField(controller: _contactController, decoration: InputDecoration(labelText: 'Contact Number'), keyboardType: TextInputType.phone),
            SizedBox(height: 10),
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
            TextField(controller: _usernameController, decoration: InputDecoration(labelText: 'Username')),
            SizedBox(height: 10),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 10),
            TextField(controller: _confirmPasswordController, decoration: InputDecoration(labelText: 'Confirm Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _handleRegistration, child: Text('Register')),
          ],
        ),
      ),
    );
  }
}

