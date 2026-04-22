import 'package:flutter/material.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("En attente", style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text("Votre compte est en attente de validation"),
          ],
        ),
      ),
    );
  }
}
