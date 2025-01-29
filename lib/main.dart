import 'package:flutter/material.dart';
import 'dart:convert'; // For parsing JSON
import 'package:flutter/services.dart'; // For accessing assets like JSON files

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


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String? userInput;
  String? errorMessage;
  List<String> uniqueIds = [];

  @override
  void initState() {
    super.initState();
    // Load the unique IDs when the app starts
    _loadUniqueIds();
  }

  // Function to load unique IDs from the JSON file
  Future<void> _loadUniqueIds() async {
    // Load the JSON file from assets
    String jsonString = await rootBundle.loadString('assets/ids.json');
    // Parse the JSON and extract the unique IDs
    List<dynamic> jsonData = json.decode(jsonString);
    // Save the IDs into the `_uniqueIds` list
    setState(() {
      uniqueIds = jsonData.map((item) => item['id'].toString()).toList();
    });
  }
  void _validateAndLogin() {
    if (userInput == null || userInput!.isEmpty) {
      // Input is empty
      setState(() {
        errorMessage = "Unique ID cannot be empty!";
      });
    } else if (!uniqueIds.contains(userInput)) {
      // Input is invalid
      setState(() {
        errorMessage = "Invalid Unique ID!";
      });
    } else {
      // Input is valid; navigate to the home page
      setState(() {
        errorMessage = null; // Clear error message
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

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
              padding: EdgeInsets.symmetric(horizontal: 32), 
              child: TextField(
                onChanged: (value){
                  userInput = value;
                },
                decoration: InputDecoration(
                  hintText: 'Unique ID',
                  border: OutlineInputBorder(),
                  errorText: errorMessage,
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 140),
              
            child: ElevatedButton( 
              onPressed: _validateAndLogin,
                
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => const HomePage())
                // );
            //On pressed currently skips straight to homepage
            
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
