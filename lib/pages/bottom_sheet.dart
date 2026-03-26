import 'package:flutter/material.dart';

const Duration _kBottomSheetDuration = Duration(milliseconds: 200);

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
    this.animationController,
    required this.onClosing,
    required this.builder,
  });

  final AnimationController? animationController;
  final VoidCallback onClosing;
  final WidgetBuilder builder;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();

  static AnimationController createAnimationController(TickerProvider vsync) {
    return AnimationController(
      duration: _kBottomSheetDuration,
      debugLabel: 'BottomSheet',
      vsync: vsync,
    );
  }
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    );
  }
}