import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart'; // For accessing assets like JSON files
import 'package:path_provider/path_provider.dart';
import 'welcome_page.dart';

class SwipePages extends StatefulWidget {
  const SwipePages({super.key});

  @override
  State<SwipePages> createState() => _SwipePagesState();
}

class _SwipePagesState extends State<SwipePages> {
  final PageController _pageController = PageController();

  String? userInput;
  String? errorMessage;
  List<Map<String, dynamic>> jsonData = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadUniqueIds(); // Load JSON data when the app starts
  }

  // Function to load unique IDs from the JSON file
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/ids.json');
  }

  Future<void> _initializeJsonFile() async {
    final file = await _getLocalFile();
    bool fileExists = await file.exists();

    if (!fileExists) {
      String jsonString = await rootBundle.loadString('assets/ids.json');
      await file.writeAsString(jsonString);
    }
  }

  Future<void> _loadUniqueIds() async {
    await _initializeJsonFile();
    final file = await _getLocalFile();
    String contents = await file.readAsString();
    List<dynamic> jsonList = json.decode(contents);
    setState(() {
      jsonData = jsonList.map((item) => item as Map<String, dynamic>).toList();
    });
  }

  Future<void> _writeJson(List<dynamic> jsonList) async {
    final file = await _getLocalFile();
    await file.writeAsString(json.encode(jsonList));
  }

  void _validateAndLogin() async {
    if (userInput == null || userInput!.isEmpty) {
      setState(() {
        errorMessage = "Unique ID cannot be empty!";
      });
      return;
    }

    // Reload the JSON from the local file
    await _loadUniqueIds();

    // Find the user based on the updated list
    Map<String, dynamic>? userJson = jsonData.firstWhere(
          (item) => item['id'] == userInput,
      orElse: () => {},
    );

    print(userJson); // Debug: See if the user exists

    if (userJson.isEmpty) {
      setState(() {
        errorMessage = "Invalid Unique ID!";
      });
    } else {
      setState(() {
        errorMessage = null;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(userJson: userJson),
        ),
      );
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  // Build login page content (without its own Scaffold)
  Widget _buildLoginPageContent() {
    return Stack(
      children: <Widget>[
        // Logo at the top
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 128),
            child: Image.asset('assets/logo_with_text.png'),
          ),
        ),
        // Label for the text field
        Positioned(
          top: 360,
          left: MediaQuery.of(context).size.width / 2 - 90,
          child: Text(
            'Enter Your Unique ID Here: ',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Verdana',
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        // Unique ID text field
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: TextField(
              onChanged: (value) {
                userInput = value;
              },
              // Disable interactive selection to remove the extra toolbar
              enableInteractiveSelection: false,
              decoration: InputDecoration(
                hintText: 'Unique ID',
                border: const OutlineInputBorder(),
                errorText: errorMessage,
              ),
            ),
          ),
        ),
        // Login button
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 140),
            child: ElevatedButton(
              onPressed: _validateAndLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text('Enter'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Prevents automatic resizing when the keyboard appears
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: <Widget>[
              _buildLoginPageContent(),
              const SignUpPage(),
            ],
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// SignUpPage widget without its own Scaffold to avoid conflicts,
// and with a SingleChildScrollView to prevent overflow when the keyboard appears.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  String? generatedId;
  String? errorMessage;

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/ids.json');
  }

  Future<List<dynamic>> _readJson() async {
    final file = await _getLocalFile();
    String contents = await file.readAsString();
    return json.decode(contents);
  }

  Future<void> _writeJson(List<dynamic> jsonList) async {
    final file = await _getLocalFile();
    await file.writeAsString(json.encode(jsonList));
  }

  void _generateUniqueId() async {
    String fullName = _nameController.text.trim();

    if (fullName.isEmpty || !fullName.contains(' ')) {
      setState(() {
        errorMessage = "Please enter both first and last names.";
      });
      return;
    }

    // Split the full name into first and last names
    List<String> nameParts = fullName.split(' ');
    String firstName = nameParts.first;
    String lastName = nameParts.last;

    // Extract first 3 letters from the last name
    String lastNamePart;
    if (lastName.length >= 3) {
      lastNamePart = lastName.substring(0, 3).toUpperCase();
    } else {
      lastNamePart = lastName.toUpperCase().padRight(3, 'X');
    }

    // Get current month and year
    DateTime now = DateTime.now();
    String monthYearPart =
        "${now.month.toString().padLeft(2, '0')}${now.year.toString().substring(2)}";

    // Load existing users from local file (NOT assets)
    List<dynamic> jsonList = await _readJson();

    // Calculate the next client number
    int clientNumber = jsonList.length + 1;
    String clientNumberPart = clientNumber.toString().padLeft(3, '0');

    // Combine all parts to create the unique ID
    String uniqueId = "$lastNamePart$monthYearPart$clientNumberPart";

    setState(() {
      generatedId = uniqueId;
      errorMessage = null; // Clear error message on success
    });

    // Add new user to the JSON list
    Map<String, dynamic> newUser = {
      "id": uniqueId,
      "name": fullName,
    };

    jsonList.add(newUser);

    // Write updated list to local file
    await _writeJson(jsonList);

    print("New User Added: $newUser");
  }

  // Copy generated ID to clipboard with a SnackBar confirmation
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Copied to clipboard!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Allows scrolling when keyboard appears
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Logo at the top
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 128),
                child: Image.asset('assets/logo.png'),
              ),
            ),
            const SizedBox(height: 60),
            Text(
              "Don't have an ID yet? Sign up here:",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Verdana',
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 45),
            // Name input field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'First & Last Name',
                border: const OutlineInputBorder(),
                errorText: errorMessage,
              ),
            ),
            const SizedBox(height: 20),
            // Display generated ID which is tappable to copy
            if (generatedId != null)
              GestureDetector(
                onTap: () => _copyToClipboard(generatedId!),
                child: Text(
                  "Generated ID: $generatedId\n(Tap to copy)",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            // Register button
            ElevatedButton(
              onPressed: _generateUniqueId,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
