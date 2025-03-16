import 'package:flutter/material.dart';
import 'dart:io';
import 'r_card_tips.dart';
import 'r_card_a.dart';
import 'package:lluvia_lens/output_screen.dart';

class RCardB extends StatelessWidget {
  final String? imagePath; // Nullable imagePath

  const RCardB({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 18, left: 20, right: 20),
              child: Text(
                "Is this image clear and focused? If not happy, please retake. Otherwise, process results.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
            ),
            const Spacer(),

            // Display captured image if available, otherwise show placeholder
            imagePath != null
                ? Image.file(File(imagePath!))
                : const Image(image: AssetImage('assets/image_placeholder.jpg'), width: 300),

            const Spacer(),
            Row(
              children: [
                const Spacer(flex: 2),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RCardTips()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 127, 163),
                  ),
                  child: const Text(
                    'Happy!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RCardA()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 127, 163),
                  ),
                  child: const Text(
                    'Retake Image!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: imagePath != null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (context) => WaterQualityOutputScreen(imagePath: imagePath!),
                      builder: (context) => WaterQualityOutputScreen(),
                  ),
                );
              }
                  : null, // Disable if no image is present
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Process Image',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
