import 'package:flutter/material.dart';
import 'water_sampling_source_a.dart';

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
            const Spacer(flex:2),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WaterSamplingSourceA()),
                );
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
              ),
              child: const Text('Next', style: TextStyle(color: Colors.white,),), 
            ),
            const Spacer(flex:1),
          ],
        ),
      ),
    );
  }
}