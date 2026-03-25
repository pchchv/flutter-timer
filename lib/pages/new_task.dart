import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class _Selector<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemBuilder;
  final Function(T) onSelectedItemChanged;

  const _Selector({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.onSelectedItemChanged,
  });

  @override
  _SelectorState<T> createState() => _SelectorState<T>();
}

class _SelectorState<T> extends State<_Selector<T>> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker.builder(
      itemExtent: 60,
      childCount: widget.items.length,
      backgroundColor: Colors.transparent,
    );
  }
}
