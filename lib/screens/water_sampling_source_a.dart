import 'package:flutter/material.dart';
import 'water_source_photo_placeholder.dart';

class WaterSamplingSourceA extends StatelessWidget {
  const WaterSamplingSourceA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Text("Capture an image of the water sampling\nsource. Please ensure the entire tank or\nflush diverter and its surrounding\nenvironment are visible. Frame the scene\nto include both the system and its setting."),
            const Spacer(),
            const Image(image: AssetImage('assets/watersystem.png'), width:300),
            const Spacer(),
            ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WaterSourcePhotoPlaceHolder()),
                );
            },
            style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
            ),
            child: const Text('Capture Image', style: TextStyle(color: Colors.white,),),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}