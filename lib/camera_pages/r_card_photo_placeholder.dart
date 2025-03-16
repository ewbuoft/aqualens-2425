import 'package:flutter/material.dart';
import 'r_card_b.dart';

class RCardPhotoPlaceholder extends StatelessWidget {
  final String imagePath;

  const RCardPhotoPlaceholder({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text('Insert Photo Taking Page Here!'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Pass the imagePath to RCardB when navigating
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RCardB(imagePath: imagePath),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 127, 163),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
