import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cipher Comm'),
      ),
      body: Center(
        child: Text(
          'Welcome to Cipher Comm!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
