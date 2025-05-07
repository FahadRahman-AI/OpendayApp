import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'intro_screen.dart';
import 'pages_layout.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  String email = '';
  String password = '';
  String dob = '';
  String contact = '';
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    _loadAccountData();
  }

  // Load data from SharedPreferences and FlutterSecureStorage
  Future<void> _loadAccountData() async {
    final prefs = await SharedPreferences.getInstance();
    final storedPassword = await secureStorage.read(key: 'password');

    setState(() {
      email = prefs.getString('email') ?? 'No email available';
      dob = prefs.getString('dob') ?? 'No date of birth available';
      contact = prefs.getString('contact') ?? 'No phone number available';
      password = storedPassword ?? 'No password set';

      // Log the loaded values to the console for debugging
      print('Loaded Email: $email');
      print('Loaded Date of Birth: $dob');
      print('Loaded Contact: $contact');
      print('Loaded Password: $password');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'My Account',
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _infoTile('Email', email),
            SizedBox(height: 10),
            _infoTile(
              'Password',
              showPassword ? password : '••••••',
              trailing: TextButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                child: Text(showPassword ? 'Hide' : 'Show'),
              ),
            ),
            SizedBox(height: 10),
            _infoTile('Date of Birth', dob),
            SizedBox(height: 10),
            _infoTile('Phone Number', contact),
            SizedBox(height:250),
            ElevatedButton(
              onPressed: () async {
                // Clear data on log out
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // Clear all data from SharedPreferences
                await FlutterSecureStorage().deleteAll(); // Clear all data from FlutterSecureStorage

                // Navigate to the IntroScreen (Homepage)
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => IntroScreen()),
                );
              },
                child: Text('Log Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: EdgeInsets.symmetric(vertical:15.0),
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value, {Widget? trailing}) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value, style: TextStyle(color: Colors.black)), // Changed to black color
      trailing: trailing,
      contentPadding: EdgeInsets.zero,
    );
  }
}
