import 'package:flutter/material.dart';
import 'login_and_signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(0, 127, 163, 1.0), // Pantone 633
      ),
      home: const SwipePages(),
      debugShowCheckedModeBanner: false,
    );
  }
}
