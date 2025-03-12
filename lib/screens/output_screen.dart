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
      final byteData = await rootBundle.load('assets/test_sample.jpg');
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

    // Use the new method from api_service.dart
    var result = await ApiService.analyzeImageFromBytes(testImageBytes!, "test_user");

    if (result != null) {
      print("✅ API Response: $result");
      setState(() {
        colonyCount = result["colony_count"];
        riskLevel = result["risk_level"].toUpperCase();
        description = "This level of bacterial contamination exceeds WHO standards.";
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text("Analyzing Image...", style: TextStyle(fontSize: 16)),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (testImageBytes != null)
                      Image.memory(testImageBytes!, height: 150),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: riskColor,
                        borderRadius: BorderRadius.circular(12),
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
                    const SizedBox(height: 20),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text(
                        "Share in Database",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
