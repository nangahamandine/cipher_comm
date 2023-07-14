import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[100]!, Colors.white!, Colors.grey[100]!],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(40, 80, 40, 20), // Adjust the padding
              child: Image(
                image: AssetImage('assets/images/PNGLogo.png'),
                fit: BoxFit.scaleDown,
                height: 180, // Adjust the height of the logo
              ),
            ),
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to a Next-Level Experience of Seamless Communication, Collaboration and Security',
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 80), // Adjust the spacing
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
                  SizedBox(height: 24),
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
                        primary: Colors.white,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cipher Comm',
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
      },
    );
  }
}
