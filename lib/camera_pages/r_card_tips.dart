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
            const Image(image: AssetImage('assets/logo.png'), width:100),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 4), // Adjust the offset as needed
                        child: const Icon(Icons.water_drop, size: 12, color: Colors.blue),
                      ),
                      const SizedBox(width: 8),
                      const Flexible(
                        child: Text(
                          'Put on gloves to keep everything clean and safe.',
                          style: TextStyle(fontSize: 18),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 4),
                        child: const Icon(Icons.water_drop, size: 12, color: Colors.blue),
                      ),
                      const SizedBox(width: 8),
                      const Flexible(
                        child: Text(
                          'Open the Testing R-Card and lift the transparent film.',
                          style: TextStyle(fontSize: 18),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 4),
                        child: const Icon(Icons.water_drop, size: 12, color: Colors.blue),
                      ),
                      const SizedBox(width: 8),
                      const Flexible(
                        child: Text(
                          'Using the 1mL pipette, gently put 1 mL of your selected water sample right in the middle of the testing card and cover with the transparent film.',
                          style: TextStyle(fontSize: 18),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 4),
                        child: const Icon(Icons.water_drop, size: 12, color: Colors.blue),
                      ),
                      const SizedBox(width: 8),
                      const Flexible(
                        child: Text(
                          'Wait for about 1 minute to let the liquid spread evenly across the card.',
                          style: TextStyle(fontSize: 18),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, 4),
                        child: const Icon(Icons.water_drop, size: 12, color: Colors.blue),
                      ),
                      const SizedBox(width: 8),
                      const Flexible(
                        child: Text(
                          'Place the card in an incubator. Set the temperature to about 35 degrees Celsius. Leave it there for 15 to 24 hours.',
                          style: TextStyle(fontSize: 18),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

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