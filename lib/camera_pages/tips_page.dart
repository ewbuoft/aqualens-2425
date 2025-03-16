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
            const Image(
                image: AssetImage('assets/logo.png'),
                width: 100
            ),

            const Spacer(flex:1),
            const Padding(
              padding: EdgeInsets.only(top: 18, left: 20, right: 20), // 18 top, 20 left and right padding
              child: Text(
                '1. For the best results, keep your hands still or rest your phone on something to avoid blurry pictures.\n\n2. Try to avoid shadows and reflections.\n\n3. Tap on screen to focus properly.',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20), // Adjusted font size
              ),
            ),

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