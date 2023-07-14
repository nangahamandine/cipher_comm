import 'dart:async';
import 'package:cipher_comm/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      throw Exception('Both email and password are required fields.');
    } else if (email != 'example@example.com' || password != 'password') {
      throw Exception('Wrong email or password.');
    } else {
      _showSuccessDialog();
      Timer(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Login was successful.'),
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
          'Login',
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
            SizedBox(height: 40.0), // Adjusted spacing
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset(
                'assets/images/top2.png',
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
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 18.0),
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
                  SizedBox(height: 60.0), // Adjusted spacing
                  ElevatedButton(
                    onPressed: () {
                      try {
                        _login();
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
                      padding: EdgeInsets.symmetric(vertical: 10.0), // Increased height
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 24,
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
