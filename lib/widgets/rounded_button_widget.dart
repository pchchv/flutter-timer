import 'package:flutter/material.dart';

class RoundedButton extends StatefulWidget {
  final String text;

  const RoundedButton({super.key, required this.text});

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      height: 140.0,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0
            )
          ]
      ),
      child: Center(
        child: Text(
          widget.text,
          style: const TextStyle(
              fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}