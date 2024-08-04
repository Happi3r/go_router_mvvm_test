import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              context.replace('/home');
            },
            child: const Text('to Home'),
          ),
        ),
      ),
    );
  }
}
