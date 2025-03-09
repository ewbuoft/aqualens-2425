import 'package:flutter/material.dart';
import 'water_tap_photo_placeholder.dart';

class WaterTapA extends StatelessWidget {
  const WaterTapA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Text("Please capture a clear image of the water\n tap. Focus closely so that the tap and any\nconnecting fixtures are clearly visible."),
            const Spacer(),
            const Image(image: AssetImage('assets/waterpipe.png'), width:300),
            const Spacer(),
            ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WaterTapPhotoPlaceHolder()),
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