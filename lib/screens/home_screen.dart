import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('SignOut'),
          onPressed: () {
            FirebaseAuth auth = FirebaseAuth.instance;
            auth.signOut();
          },
        ),
      ),
    );
  }
}
