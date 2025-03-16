import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:lluvia_lens/photo_capture.dart';
import 'r_card_b.dart';

class RCardA extends StatefulWidget {
  const RCardA({super.key});

  @override
  _RCardAState createState() => _RCardAState();
}

class _RCardAState extends State<RCardA> {
  late List<CameraDescription> cameras;
  bool isCameraInitializing = true;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  // Initialize the cameras asynchronously
  Future<void> _initializeCameras() async {
    try {
      cameras = await availableCameras();
    } catch (e) {
      print("Camera initialization error: $e");
    }
    setState(() {
      isCameraInitializing = false; // Camera initialization is complete
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: isCameraInitializing
            ? const CircularProgressIndicator() // Show loading indicator while initializing
            : Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 18, left: 20, right: 20),
              child: Text(
                "Please take a photo of the R-card after 24 hours. Make sure the card is in a well-lit area, the grid area is centered and fitting in the box, and clearly visible from the top.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
            ),
            const Spacer(),
            const Image(image: AssetImage('assets/rcard.png'), width: 300),
            const Spacer(),
            ElevatedButton(
              onPressed: cameras.isEmpty
                  ? null
                  : () async {
                // Capture the image and pass it to the next screen
                final imagePath = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PhotoCaptureScreen(camera: cameras.first),
                  ),
                );

                if (imagePath != null) {
                  // After capturing the image, pass the path to RCardB
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RCardB(imagePath: imagePath),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 127, 163),
              ),
              child: const Text(
                'Capture Image',
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
