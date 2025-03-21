import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://aqualens-2425.onrender.com";

  // Analyzes image using memory-based bytes and userId
  static Future<Map<String, dynamic>?> analyzeImageFromBytes(Uint8List imageBytes, String userId) async {
    try {
      print("📤 Sending image to API for analysis...");

      // Prepare multipart request
      var request = http.MultipartRequest('POST', Uri.parse("$baseUrl/analyze"));

      // Add the user_id as a form field
      request.fields['user_id'] = userId;

      // Add image as bytes (using a filename that is generic for API compatibility)
      request.files.add(http.MultipartFile.fromBytes('file', imageBytes, filename: 'water_sample.jpg'));

      // Send the request
      var response = await request.send();

      // Check status code
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print("✅ API Response: $responseBody");

        // Decode JSON response
        return jsonDecode(responseBody);
      } else {
        print("❌ API Error: Status Code ${response.statusCode}, ${response.reasonPhrase}");
        return null;
      }
    } catch (e) {
      // Handle errors (e.g., no connection, timeout, or JSON parsing issues)
      print("⚠️ Exception in API request: $e");
      return null;
    }
  }
}
