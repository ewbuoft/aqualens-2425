import 'package:flutter/material.dart';
import 'water_sampling_source_a.dart';
import 'water_tap_a.dart';

class WaterSamplingSourceB extends StatelessWidget {
  const WaterSamplingSourceB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Text("Are you happy with the capture, or would\nyou like to retake the image?"),
            const Spacer(),
            const Image(image: AssetImage('assets/image_placeholder.jpg'), width:300),
            const Spacer(),
            Row(children: [
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WaterTapA()),
                  );
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
                ),
                child: const Text('Happy!', style: TextStyle(color: Colors.white,),),
              ),
              const Spacer(),
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
                child: const Text('Retake Image!', style: TextStyle(color: Colors.white,),),
              ),
              const Spacer(flex: 2),
            ],),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}