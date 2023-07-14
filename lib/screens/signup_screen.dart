import 'dart:async';
import 'package:cipher_comm/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? _selectedDepartment;

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _signup() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String? department = _selectedDepartment;

    if (name.isEmpty || email.isEmpty || password.isEmpty || department == null) {
      throw Exception('All fields are required.');
    } else if (!email.contains('@')) {
      throw Exception('Invalid email address.');
    } else {
      _showSuccessDialog();
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Signup was successful.'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Signup',
          style: GoogleFonts.openSans(
            textStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5.0), // Adjusted spacing
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Image.asset(
                'assets/images/top3.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Employee Name',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Employee Email',
                    ),
                  ),
                  SizedBox(height: 16.0),
                  SingleChildScrollView(
                    child: DropdownButtonFormField<String>(
                      value: _selectedDepartment,
                      decoration: InputDecoration(
                        labelText: 'Department',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedDepartment = value;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: 'Department A',
                          child: Text('Department A'),
                        ),
                        DropdownMenuItem(
                          value: 'Department B',
                          child: Text('Department B'),
                        ),
                        DropdownMenuItem(
                          value: 'Department C',
                          child: Text('Department C'),
                        ),
                        DropdownMenuItem(
                          value: 'Department D',
                          child: Text('Department D'),
                        ),
                        DropdownMenuItem(
                          value: 'Department E',
                          child: Text('Department E'),
                        ),
                        DropdownMenuItem(
                          value: 'Department F',
                          child: Text('Department F'),
                        ),
                        // Add more departments as needed
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      try {
                        _signup();
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'Error',
                              style: TextStyle(color: Colors.red),
                            ),
                            content: Text(
                              e.toString(),
                              style: TextStyle(color: Colors.red),
                            ),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0), // Increased height
                    ),
                    child: Text(
                      'Signup',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
