import 'package:flutter/material.dart';
import 'dart:io';
import 'water_tap_a.dart';
import 'r_card_tips.dart';

class WaterTapB extends StatelessWidget {
  final String? imagePath;

  const WaterTapB({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 18, left: 20, right: 20), // 18 top, 20 left and right padding
              child: Text(
                "Is this image clear and focused? If not happy, please retake.",
                textAlign: TextAlign.left, // Left align the text
                style: TextStyle(fontSize: 18), // Adjust font size as needed
              ),
            ),
            const Spacer(),

            // Display the captured image if imagePath is provided, otherwise show placeholder
            imagePath != null
                ? Image.file(File(imagePath!)) // Show the captured image
                : const Image(image: AssetImage('assets/image_placeholder.jpg'), width: 300), // Placeholder if no image path

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
                    backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
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
                      MaterialPageRoute(builder: (context) => const WaterTapA()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
                  ),
                  child: const Text(
                    'Retake Image!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
