import 'package:flutter/material.dart';

const Duration _kBottomSheetDuration = Duration(milliseconds: 200);
const double _kMinFlingVelocity = 700.0;
const double _kCloseProgressThreshold = 0.5;

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
  final GlobalKey _childKey = GlobalKey(debugLabel: 'BottomSheet child');

  double get _childHeight {
    final RenderBox? renderBox = _childKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size.height ?? 0.0;
  }

  bool get _dismissUnderway => widget.animationController?.status == AnimationStatus.reverse;

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_dismissUnderway || widget.animationController == null) return;
    
    double delta = details.primaryDelta ?? 0.0;
    widget.animationController!.value -= delta / (_childHeight > 0 ? _childHeight : delta);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_dismissUnderway || widget.animationController == null) return;

    final double velocity = details.velocity.pixelsPerSecond.dy;
    final AnimationController controller = widget.animationController!;

    if (velocity > _kMinFlingVelocity) {
      final double flingVelocity = -velocity / _childHeight;
      if (controller.value > 0.0) {
        controller.fling(velocity: flingVelocity);
      }
      if (flingVelocity < 0.0) {
        widget.onClosing();
      }
    } else if (controller.value < _kCloseProgressThreshold) {
      if (controller.value > 0.0) {
        controller.fling(velocity: -1.0);
      }
      widget.onClosing();
    } else {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _handleDragUpdate,
      onVerticalDragEnd: _handleDragEnd,
      child: Material(
        key: _childKey,
        child: widget.builder(context),
      ),
    );
  }
}