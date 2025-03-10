import 'package:flutter/material.dart';
import 'r_card_tips.dart';
import 'r_card_a.dart';

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