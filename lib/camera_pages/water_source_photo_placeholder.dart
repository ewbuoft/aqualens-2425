import 'package:flutter/material.dart';
import 'water_sampling_source_b.dart';

class WaterSourcePhotoPlaceHolder extends StatelessWidget {
  final String imagePath;
  const WaterSourcePhotoPlaceHolder({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child:Column (
          children: [
            const Text('Insert Photo Taking Page Here!'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WaterSamplingSourceB()),
                );
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
              ),
              child: const Text('Continue', style: TextStyle(color: Colors.white,),),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}