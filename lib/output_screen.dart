import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../services/api_service.dart';

class WaterQualityOutputScreen extends StatefulWidget {
  final String? imagePath;
  const WaterQualityOutputScreen({Key? key, this.imagePath}) : super(key: key);

  @override
  _WaterQualityOutputScreenState createState() => _WaterQualityOutputScreenState();
}

class _WaterQualityOutputScreenState extends State<WaterQualityOutputScreen> {
  String riskLevel = "Analyzing...";
  int colonyCount = 0;
  String description = "Processing image...";
  Color riskColor = Colors.grey;
  List<Uint8List> imagesList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    print("📥 Loading image...");
    try {
      Uint8List bytes;
      if (widget.imagePath == null) {
        bytes = await File(widget.imagePath!).readAsBytes();
        print("✅ Image loaded from file");
      } else {
        final byteData = await rootBundle.load('assets/R-cardSample2.jpg');
        bytes = byteData.buffer.asUint8List();
        print("✅ Test image loaded from assets");
      }
      _fetchAnalysis(bytes);
    } catch (e) {
      print("❌ Failed to load image: $e");
      setState(() {
        riskLevel = "Error";
        description = "Failed to load image.";
        isLoading = false;
      });
    }
  }

  Future<void> _fetchAnalysis(Uint8List imageBytes) async {
    print("🚀 Sending image bytes to API for analysis...");
    setState(() {
      isLoading = true;
    });

    var result = await ApiService.analyzeImageFromBytes(imageBytes, "test_user");

    if (result != null) {
      print("✅ API Response: $result");
      setState(() {
        colonyCount = result["colony_count"];
        riskLevel = result["risk_level"].toUpperCase();

        if (riskLevel == "SAFE") {
          description =
          "This sample meets WHO standards (0 colonies per 100 mL). Regular maintenance is recommended, but no immediate action is required.";
        } else if (riskLevel == "LOW RISK") {
          description =
          "Bacterial contamination is present but still considered low-risk. WHO guidelines suggest ensuring basic water treatment to maintain safety.";
        } else if (riskLevel == "MODERATE RISK") {
          description =
          "This level of contamination can pose a health risk if untreated. WHO recommends proper disinfection (e.g., boiling, chlorination, filtration) before use.";
        } else if (riskLevel == "HIGH RISK") {
          description =
          "Significant contamination found. This exceeds WHO’s safe threshold (0 colonies per 100 mL). Do not drink without thorough treatment and inspect your rainwater system for possible contamination sources.";
        }

        riskColor = (riskLevel == "SAFE")
            ? const Color(0xFF7CC7EB)
            : (riskLevel == "LOW RISK")
            ? const Color(0xFF35A189)
            : (riskLevel == "MODERATE RISK")
            ? const Color(0xFFEDBF31)
            : const Color(0xFFD24630);

        // Decode Base64 images from API response
        List<dynamic> base64Images = result["images"];
        imagesList = base64Images.map((imgStr) => base64Decode(imgStr)).toList();

        isLoading = false;
      });
    } else {
      print("❌ API Request Failed");
      setState(() {
        riskLevel = "Error";
        description = "Failed to analyze image.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Water Quality Analysis"),
        backgroundColor: riskColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Analyzing Image...", style: TextStyle(fontSize: 16)),
          ],
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Display images in a 2x2 grid pattern
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.0,
              ),
              itemCount: imagesList.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    imagesList[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // RISK PANEL
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: riskColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  Text(
                    riskLevel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$colonyCount bacteriological colonies per mL",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // DESCRIPTION TEXT
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),

            // ACTION BUTTONS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  onPressed: () {
                    // Show explanation or navigate
                  },
                  child: const Text("What This Means"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  onPressed: () {
                    // Show recommended actions
                  },
                  child: const Text("Recommended Actions"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 14),
              ),
              onPressed: () {
                // TODO: Implement "Share in Database"
              },
              child: const Text("Share in Database"),
            ),
          ],
        ),
      ),
    );
  }
}

