import 'package:cipher_comm/screens/chat_screen.dart';
import 'package:cipher_comm/screens/home_screen.dart';
import 'package:cipher_comm/screens/login_screen.dart';
import 'package:cipher_comm/screens/signup_screen.dart';
import 'package:cipher_comm/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cipher Comm',
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
