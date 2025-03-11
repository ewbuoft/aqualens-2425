import 'package:flutter/material.dart';

class WaterQualityResultScreen extends StatelessWidget {
  final String riskLevel;
  final int colonyCount;
  final String description;
  final Color riskColor;

  const WaterQualityResultScreen({
    Key? key,
    required this.riskLevel,
    required this.colonyCount,
    required this.description,
    required this.riskColor,
  }) : super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Quality Analysis"),
        backgroundColor: riskColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: riskColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    riskLevel,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "$colonyCount bacteriological colonies per mL",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("What this means?"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Recommended Actions"),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text("Share in Database"),
            ),
          ],
        ),
      ),
    );
  }
}

// Example usage
void main() {
  runApp(MaterialApp(
    home: WaterQualityResultScreen(
      riskLevel: "HIGH RISK",
      colonyCount: 52,
      description:
          "This level of bacterial contamination exceeds the safety standards set by the WHO.",
      riskColor: Colors.red,
    ),
  ));
}
