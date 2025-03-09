import 'package:flutter/material.dart';
import 'r_card_photo_placeholder.dart';

class RCardA extends StatelessWidget {
  const RCardA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Text("Please take a photo of the R-card after\n24 hours. Make sure the card is in a\nwell-lit area, the grid area is centered\nand fitting in the box, and clearly visible\nfrom the top."),
            const Spacer(),
            const Image(image: AssetImage('assets/rcard.png'), width:300),
            const Spacer(),
            ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RCardPhotoPlaceholder()),
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