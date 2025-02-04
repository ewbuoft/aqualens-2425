import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const TipsPage(),
    );
  }
}

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Image(image: AssetImage('assets/logo.png'), width:50),
            const Text('1.  For the best results, keep your\n     hands still or rest your phone on\n     something to avoid blurry\n     pictures.\n2.  Try to avoid shadows and\n     reflections.\n3.  Tap on screen to focus\n     properly.'),
            const Spacer(flex:2),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WaterSamplingSourceA()),
                );
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
              ),
              child: const Text('Next', style: TextStyle(color: Colors.white,),), 
            ),
            const Spacer(flex:1),
          ],
        ),
      ),
    );
  }
}

class WaterSamplingSourceA extends StatelessWidget {
  const WaterSamplingSourceA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Text("Capture an image of the water sampling\nsource. Please ensure the entire tank or\nflush diverter and its surrounding\nenvironment are visible. Frame the scene\nto include both the system and its setting."),
            const Spacer(),
            const Image(image: AssetImage('assets/watersystem.png'), width:300),
            const Spacer(),
            ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WaterSourcePhotoPlaceHolder()),
                );
            },
            style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
            ),
            child: const Text('Capture Image', style: TextStyle(color: Colors.white,),),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class WaterSamplingSourceB extends StatelessWidget {
  const WaterSamplingSourceB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Text("Are you happy with the capture, or would\nyou like to retake the image?"),
            const Spacer(),
            const Image(image: AssetImage('assets/image_placeholder.jpg'), width:300),
            const Spacer(),
            Row(children: [
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WaterTapA()),
                  );
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
                ),
                child: const Text('Happy!', style: TextStyle(color: Colors.white,),),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WaterSamplingSourceA()),
                  );
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
                ),
                child: const Text('Retake Image!', style: TextStyle(color: Colors.white,),),
              ),
              const Spacer(flex: 2),
            ],),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class WaterSourcePhotoPlaceHolder extends StatelessWidget {
  const WaterSourcePhotoPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child:Column (
          children: [
            const Text('Insert Photo Taking Page Here!'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WaterSamplingSourceB()),
                );
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
              ),
              child: const Text('Continue', style: TextStyle(color: Colors.white,),),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class WaterTapA extends StatelessWidget {
  const WaterTapA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Text("Please capture a clear image of the water\n tap. Focus closely so that the tap and any\nconnecting fixtures are clearly visible."),
            const Spacer(),
            const Image(image: AssetImage('assets/waterpipe.png'), width:300),
            const Spacer(),
            ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WaterTapPhotoPlaceHolder()),
                );
            },
            style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
            ),
            child: const Text('Capture Image', style: TextStyle(color: Colors.white,),),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class WaterTapB extends StatelessWidget {
  const WaterTapB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Text("AIs this image clear and focused? If not\nhappy, please retake."),
            const Spacer(),
            const Image(image: AssetImage('assets/image_placeholder.jpg'), width:300),
            const Spacer(),
            Row(children: [
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RCardTips()),
                  );
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
                ),
                child: const Text('Happy!', style: TextStyle(color: Colors.white,),),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WaterTapA()),
                  );
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
                ),
                child: const Text('Retake Image!', style: TextStyle(color: Colors.white,),),
              ),
              const Spacer(flex: 2),
            ],),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class WaterTapPhotoPlaceHolder extends StatelessWidget {
  const WaterTapPhotoPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child:Column (
          children: [
            const Text('Insert Photo Taking Page Here!'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WaterTapB()),
                );
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
              ),
              child: const Text('Continue', style: TextStyle(color: Colors.white,),),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class RCardTips extends StatelessWidget {
  const RCardTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Image(image: AssetImage('assets/logo.png'), width:50),
            const Text('> Put on gloves to keep everything\n clean and safe.\n\n> Open the Testing R-Card and lift\nthe transparent film.\n\n> Using the 1mL pipette, gently put\n1 mL of your selected water\nsample right in the middle of the\ntesting card and cover with the\ntransparent film\n\n> Wait for about 1 minute to let the\nliquid spread evenly across the card.\n\n> Place the card in an incubator. Set\nthe temperature to about 35 \ndegress celsius. Leave it there for\n15 to 24 hours.'),
            const Spacer(flex:2),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RCardA()),
                );
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
              ),
              child: const Text('Next', style: TextStyle(color: Colors.white,),), 
            ),
            const Spacer(flex:1),
          ],
        ),
      ),
    );
  }
}

class RCardA extends StatelessWidget {
  const RCardA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Text("Please take a photo of the R-card after\n24 hours. Make sure the card is in a\nwell-lit area, the grid area is centered\nand fitting in the box, and clearly visible\nfrom the top."),
            const Spacer(),
            const Image(image: AssetImage('assets/rcard.png'), width:300),
            const Spacer(),
            ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RCardPhotoPlaceholder()),
                );
            },
            style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
            ),
            child: const Text('Capture Image', style: TextStyle(color: Colors.white,),),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class RCardB extends StatelessWidget {
  const RCardB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          children: [
            const Text("Is this image clear and focused? If not\nhappy, please retake. Otherwise, process\nresults."),
            const Spacer(),
            const Image(image: AssetImage('assets/image_placeholder.jpg'), width:300),
            const Spacer(),
            Row(children: [
              const Spacer(flex: 2),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RCardTips()),
                  );
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
                ),
                child: const Text('Happy!', style: TextStyle(color: Colors.white,),),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RCardA()),
                  );
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
                ),
                child: const Text('Retake Image!', style: TextStyle(color: Colors.white,),),
              ),
              const Spacer(flex: 2),
            ],),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class RCardPhotoPlaceholder extends StatelessWidget {
  const RCardPhotoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child:Column (
          children: [
            const Text('Insert Photo Taking Page Here!'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RCardB()),
                );
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 0, 127, 163), // background
              ),
              child: const Text('Continue', style: TextStyle(color: Colors.white,),),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class SamplePage extends StatelessWidget {
  const SamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(),
    );
  }
}
