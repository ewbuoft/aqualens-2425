import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 127, 163, 1.0), // Pantone 633
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
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
          Center(
            child: Text(
              'Insert Unique ID',
              style: TextStyle(fontSize: 18,
              fontFamily: 'verdana',
              color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
