import 'package:flutter/material.dart';
import 'r_card_a.dart';

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