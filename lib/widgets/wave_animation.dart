import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

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

  @override
  State<DemoBody> createState() => _DemoBodyState();
}

class _DemoBodyState extends State<DemoBody> with TickerProviderStateMixin {
  late AnimationController animationController; // Added late keyword

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Chained repeat for conciseness
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: AnimatedBuilder(
        animation: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) {
          // Generate wave points inside the builder for cleaner reactivity
          List<Offset> animList1 = [];
          for (int i = -2 - widget.xOffset; i <= widget.size.width.toInt() + 2; i++) {
            animList1.add(
              Offset(
                i.toDouble() + widget.xOffset,
                sin((animationController.value * 360 - i) % 360 * vector.degrees2Radians) * 10 + 30 + widget.yOffset,
              ),
            );
          }

          return ClipPath(
            clipper: WaveClipper(animationController.value, animList1),
            child: Container(
              width: widget.size.width,
              height: widget.size.height,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}