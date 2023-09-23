import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String selectedLanguage = 'English'; // Initially set to English

  // List of available languages
  List<String> languages = ['English', 'French'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white, Colors.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Image.asset(
                'assets/images/welcomeIllustration.png',
                fit: BoxFit.scaleDown,
                height: 300,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to a Next-Level Experience of Seamless Communication, Collaboration, and Security',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Login',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[100],
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Signup',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButton<String>(
                      value: selectedLanguage,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLanguage = newValue!;
                        });
                      },
                      items: languages.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

