import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final box = GetStorage();

  void _saveUsername() {
    String username = _nameController.text.trim();
    if (username.isNotEmpty) {
      box.write('username', username);
      box.write('first_time', false); // Mark first-time as false
      Navigator.pushReplacementNamed(context, '/home'); // Go to home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Enter Your Name"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUsername,
                child: Text("Continue"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
