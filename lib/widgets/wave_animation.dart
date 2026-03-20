import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  final double animation;
  final List<Offset> waveList1;

  WaveClipper(this.animation, this.waveList1);

  @override
  bool shouldReclip(WaveClipper oldClipper) => animation != oldClipper.animation;
}