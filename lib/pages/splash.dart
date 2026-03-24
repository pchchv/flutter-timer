import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  // Use super.key for modern Dart syntax
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'images/timer.png',
          width: 100.0,
          height: 100.0,
        ),
      ),
    );
  }
}