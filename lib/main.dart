import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 128),
              child: Image.asset('assets/logo_with_text.png'),
            ),
          ),

          Positioned(
            top: 360,
            left: MediaQuery.of(context).size.width / 2 - 90,
            child: Text(
              'Put Your Unique ID Here: ',
              style: TextStyle(
              fontSize: 18,
              fontFamily: 'Verdana',
              color: Theme.of(context).primaryColor, 
              ),
          ),
      ),     
         const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32), 
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Unique ID',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 140),
              
            child: ElevatedButton( 
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage())
                );
              },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
             ),
              child: const Text('Enter'
                 ),
              ),

            ),
          
          
          )
        ],
      ),
    );
  }
}

// Sample Home Page for Now
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Successful Login !!'),
        ),
      );
  }
}
