import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../services/api_service.dart';

class WaterQualityOutputScreen extends StatefulWidget {
  const WaterQualityOutputScreen({Key? key}) : super(key: key);

  @override
  _WaterQualityOutputScreenState createState() => _WaterQualityOutputScreenState();
}

class _WaterQualityOutputScreenState extends State<WaterQualityOutputScreen> {
  String riskLevel = "Analyzing...";
  int colonyCount = 0;
  String description = "Processing image...";
  Color riskColor = Colors.grey;
  Uint8List? testImageBytes; // Storing raw bytes in memory
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTestImageFromAssets();
  }

  Future<void> _loadTestImageFromAssets() async {
    print("📥 Loading test image from assets (web-friendly)...");
    try {
      final byteData = await rootBundle.load('assets/test_sample-2.jpg');
      setState(() {
        testImageBytes = byteData.buffer.asUint8List();
      });
      print("✅ Test image loaded in memory");
      _fetchAnalysis();
    } catch (e) {
      print("❌ Failed to load image: $e");
    }
  }

  Future<void> _fetchAnalysis() async {
    print("🚀 Sending image bytes to API for analysis...");
    setState(() {
      isLoading = true;
    });

    if (testImageBytes == null) {
      print("❌ No image bytes available.");
      setState(() {
        riskLevel = "Error";
        description = "No image available for analysis.";
        isLoading = false;
      });
      return;
    }

    var result = await ApiService.analyzeImageFromBytes(testImageBytes!, "test_user");

    if (result != null) {
      print("✅ API Response: $result");
      setState(() {
        colonyCount = result["colony_count"];
        riskLevel = result["risk_level"].toUpperCase();
        // Dynamically set the description
        if (riskLevel == "SAFE") {
          description = "Your water meets WHO standards (0 colonies per 100 mL).";
        } else if (riskLevel == "LOW") {
          description = "The bacterial contamination is low, but you may still want to treat the water.";
        } else if (riskLevel == "MEDIUM") {
          description = "This level of contamination may pose health risks without treatment.";
        } else if (riskLevel == "HIGH") {
          description = "This level of contamination exceeds WHO standards. Treatment is strongly recommended.";
        }
        riskColor = (riskLevel == "SAFE")
            ? Colors.green
            : (riskLevel == "LOW")
                ? Colors.blue
                : (riskLevel == "MEDIUM")
                    ? Colors.orange
                    : Colors.red;
        isLoading = false;
      });
    } else {
      print("❌ API Request Failed");
      setState(() {
        riskLevel = "Error";
        description = "Failed to analyze test image.";
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
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
                  // MAIN IMAGE
                  if (testImageBytes != null)
                    Image.memory(
                      testImageBytes!,
                      height: 150,
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        onPressed: () {
                          // Show explanation or navigate
                        },
                        child: const Text("What this means?"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Theme.of(context).primaryColor,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                    onPressed: () {
                      // TODO: Implement "Share in Database"
                    },
                    child: const Text("Share in Database"),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
