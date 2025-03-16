import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:lluvia_lens/photo_capture.dart';
import 'water_sampling_source_b.dart';

class WaterSamplingSourceA extends StatefulWidget {
  const WaterSamplingSourceA({super.key});

  @override
  _WaterSamplingSourceAState createState() => _WaterSamplingSourceAState();
}

class _WaterSamplingSourceAState extends State<WaterSamplingSourceA> {
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
              padding: EdgeInsets.only(top: 18, left: 20, right: 20),
              child: Text(
                "Capture an image of the water sampling source. Please ensure the entire tank or flush diverter and its surrounding environment are visible. Frame the scene to include both the system and its setting.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18),
              ),
            ),
            const Spacer(),
            const Image(image: AssetImage('assets/watersystem.png'), width: 300),
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
                  // After capturing the image, pass the path to WaterSamplingSourceB
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WaterSamplingSourceB(imagePath: imagePath),
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
