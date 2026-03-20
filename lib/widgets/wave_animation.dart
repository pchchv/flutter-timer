import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  final double animation;
  final List<Offset> waveList1;

  WaveClipper(this.animation, this.waveList1);

  @override
  bool shouldReclip(WaveClipper oldClipper) => animation != oldClipper.animation;

  @override
  Path getClip(Size size) {
    final Path path = Path();
    if (waveList1.isNotEmpty) {
      path.addPolygon(waveList1, false);
      path.lineTo(size.width, size.height);
      path.lineTo(0.0, size.height);
      path.close();
    }
    return path;
  }
}

class DemoBody extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color? color; // Marked as nullable

  // Used super.key and required keyword
  const DemoBody({
    super.key,
    required this.size,
    this.xOffset = 0,
    this.yOffset = 0,
    this.color,
  });
}
