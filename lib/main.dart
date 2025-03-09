import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';


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
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  List<String> _validIds = [];

  @override
  void initState() {
    super.initState();
    _loadIds();
  }

Future<void> _loadIds() async {
  final String data = await rootBundle.loadString('assets/ids.json');
  final Map<String, dynamic> jsonResult = json.decode(data);
  setState(() {
    _validIds = List<String>.from(jsonResult['ids']);

  });
  print('Loaded IDs: $_validIds');
}


void _handleLogin() {
    final String enteredId = _idController.text.trim();
    print('Entered ID: $enteredId');
    print('Valid IDs: $_validIds');
    if (_validIds.contains(enteredId)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid ID. Please try again.')),
      );
    }
  }

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
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32), 
              child: TextField(
                controller: _idController,
                decoration: const InputDecoration(
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
              onPressed: _handleLogin,
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
    return const Scaffold(
      body: Center(
        child: Text('Successful Login !!'),
        ),
      );
  }
}