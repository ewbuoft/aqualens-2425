import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const TipsPage(),
    );
  }
}

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Image(image: AssetImage('assets/logo.png'), width:50),
            const Text('1.  For the best results, keep your\n     hands still or rest your phone on\n     something to avoid blurry\n     pictures.\n2.  Try to avoid shadows and\n     reflections.\n3.  Tap on screen to focus\n     properly.'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SamplePage()),
                );
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
              ),
              child: const Text('Next', style: TextStyle(color: Colors.white,),), 
            ),
          ],
        ),
      ),
    );
  }
}

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
