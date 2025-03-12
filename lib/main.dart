import 'package:flutter/material.dart';
import 'login_and_signup.dart';
// import 'camera_pages/tips_page.dart';

void main() {
  runApp(const MyApp());
}
/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CGEN LluviaLens',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(0, 127, 163, 1.0), // Pantone 633
      ),
      home: const SwipePages(),
      debugShowCheckedModeBanner: false,
    );
  }
}
*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CGEN Aqualens',
      theme: ThemeData(
          useMaterial3: true,

          colorScheme: const ColorScheme (
              brightness: Brightness.light,
              primary:  Color.fromRGBO(0, 127, 163, 1.0),
              onPrimary: Colors.white,
              secondary: Color.fromRGBO(111, 199, 234, 1.0),
              onSecondary: Colors.black,
              error: Color.fromRGBO(220, 70, 51, 1.0),
              onError: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black)
      ),
      darkTheme: ThemeData(
          useMaterial3: true,

          colorScheme: const ColorScheme (
              brightness: Brightness.light,
              primary:  Color.fromRGBO(0, 127, 163, 1.0),
              onPrimary: Colors.white,
              secondary: Color.fromRGBO(111, 199, 234, 1.0),
              onSecondary: Colors.black,
              error: Color.fromRGBO(220, 70, 51, 1.0),
              onError: Colors.white,
              surface: Colors.black,
              onSurface: Colors.white)
      ),
      home: const SwipePages(),
      debugShowCheckedModeBanner: false,
    );
  }
}

