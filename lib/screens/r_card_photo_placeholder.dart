import 'package:flutter/material.dart';
import 'r_card_b.dart';

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