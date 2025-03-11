import 'package:flutter/material.dart';
import 'water_tap_a.dart';
import 'r_card_tips.dart';

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