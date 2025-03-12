import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:aqualens/main.dart';


export 'package:aqualens/pages/login.dart';

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
    return Stack(
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
    );
  }
} 