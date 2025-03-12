import 'package:flutter/material.dart';
import 'homepage.dart';

class WelcomePage extends StatefulWidget {
  final Map<String, dynamic> userJson;

  const WelcomePage({super.key, required this.userJson});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();

    // Add a delay before navigating to HomePage
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to the HomePage after the delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Welcome, ',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF007FA3),
                ),
              ),
              TextSpan(
                text: '${widget.userJson['name'] ?? 'Guest'}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF007FA3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
