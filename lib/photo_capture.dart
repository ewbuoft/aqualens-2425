import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class PhotoCaptureScreen extends StatefulWidget {
  final CameraDescription camera;

  const PhotoCaptureScreen({super.key, required this.camera});

  @override
  _PhotoCaptureScreenState createState() => _PhotoCaptureScreenState();
}

class _PhotoCaptureScreenState extends State<PhotoCaptureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _captureAndSavePhoto() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/photo_${DateTime.now().millisecondsSinceEpoch}.png';

      await File(image.path).copy(filePath); // Save the captured photo

      if (!context.mounted) return;

      Navigator.pop(context, filePath); // Return the photo path
    } catch (e) {
      print("Error capturing photo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Capture Image")),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: FloatingActionButton(
                onPressed: _captureAndSavePhoto,
                backgroundColor: const Color(0xFF007FA3),
                heroTag: "captureButton",
                child: const Icon(Icons.camera_alt, size: 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
