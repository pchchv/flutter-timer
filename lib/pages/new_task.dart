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
      itemBuilder: (context, index) {
        final bool isSelected = (_currentIndex == index);
        final item = widget.items[index];

        return Center(
          child: Text(
            widget.itemBuilder(item),
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Theme.of(context).colorScheme.secondary : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      },
      onSelectedItemChanged: (i) {
        setState(() {
          _currentIndex = i;
        });
        widget.onSelectedItemChanged(widget.items[i]);
      },
    );
  }
}
