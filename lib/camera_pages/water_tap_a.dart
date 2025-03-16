import 'package:lluvia_lens/camera_pages/water_tap_b.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:lluvia_lens/photo_capture.dart';

class WaterTapA extends StatefulWidget {
  const WaterTapA({super.key});

  @override
  _WaterTapAState createState() => _WaterTapAState();
}

class _WaterTapAState extends State<WaterTapA> {
  late List<CameraDescription> cameras;
  bool isCameraInitializing = true; // To track the camera initialization state

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
              padding: EdgeInsets.only(top: 18, left: 20, right: 20), // 18 top, 20 left and right padding
              child: Text(
                "Please capture a clear image of the water tap. Focus closely so that the tap and any connecting fixtures are clearly visible.",
                textAlign: TextAlign.left, // Left align the text
                style: TextStyle(fontSize: 18), // Adjust font size as needed
              ),
            ),
            const Spacer(),
            const Image(image: AssetImage('assets/waterpipe.png'), width: 300),
            const Spacer(),
            ElevatedButton(
              onPressed: cameras.isEmpty
                  ? null
                  : () async {
                final imagePath = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoCaptureScreen(camera: cameras.first),
                  ),
                );

                if (imagePath != null) {
                  // After capturing the image, pass the path to WaterTapPhotoPlaceHolder
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaterTapB(imagePath: imagePath),
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
