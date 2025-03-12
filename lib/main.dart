// import 'package:flutter/material.dart';
// import 'login_and_signup.dart';
// // import 'camera_pages/tips_page.dart';
// import 'screens/output_screen.dart'; // Import the output screen

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login Page',
//       theme: ThemeData(
//         primaryColor: const Color.fromRGBO(0, 127, 163, 1.0), // Pantone 633
//       ),
//       home: const SwipePages(),
//       debugShowCheckedModeBanner: false,
//       // home: const WaterQualityOutputScreen(
//       //   riskLevel: "HIGH RISK",
//       //   colonyCount: 52,
//       //   description: "This level of bacterial contamination exceeds the safety standards set by WHO.",
//       //   riskColor: Colors.red,
//       // ), debugShowCheckedModeBanner: false,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'screens/output_screen.dart';

void main() {
  runApp(const MaterialApp(
    home: WaterQualityOutputScreen(),
    debugShowCheckedModeBanner: false,
  ));
}
