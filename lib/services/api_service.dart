import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://127.0.0.1:5000"; // or your Flask URL

  static Future<Map<String, dynamic>?> analyzeImageFromBytes(Uint8List imageBytes, String userId) async {
    try {
      print("📤 Preparing memory-based image request to API...");

      // Create a multipart request
      var request = http.MultipartRequest('POST', Uri.parse("$baseUrl/analyze"));

      // Add the user_id field
      request.fields['user_id'] = userId;

      // Add the image as bytes (web-compatible)
      request.files.add(
        http.MultipartFile.fromBytes('file', imageBytes, filename: 'test.jpg'),
      );

      // Send the request
      var response = await request.send();
      print("📬 Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print("✅ API Response: $responseBody");
        return jsonDecode(responseBody);
      } else {
        print("❌ API Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("⚠️ Exception in API request: $e");
      return null;
    }
  }
}
