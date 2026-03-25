import 'package:flutter/material.dart';

class NumberPicker extends StatelessWidget {
  static const double defaultItemExtent = 50.0;
  static const double defaultListViewWidth = 100.0;

  const NumberPicker.horizontal({
    super.key,
    required int initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    this.itemExtent = defaultItemExtent,
    this.listViewWidth = defaultListViewWidth + 50,
    this.step = 1,
  })  : assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        scrollDirection = Axis.horizontal,
        selectedIntValue = initialValue,
        selectedDecimalValue = -1,
        decimalPlaces = 0,
        intScrollController = null,
        decimalScrollController = null,
        _listViewHeight = 3 * itemExtent;

  const NumberPicker.integer({
    super.key,
    required int initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    this.itemExtent = defaultItemExtent,
    this.listViewWidth = defaultListViewWidth,
    this.step = 1,
    this.scrollDirection = Axis.vertical,
  })  : assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        selectedIntValue = initialValue,
        selectedDecimalValue = -1,
        decimalPlaces = 0,
        intScrollController = null,
        decimalScrollController = null,
        _listViewHeight = 3 * itemExtent;

    NumberPicker.decimal({
    super.key,
    required double initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    this.decimalPlaces = 1,
    this.itemExtent = defaultItemExtent,
    this.listViewWidth = defaultListViewWidth,
    this.scrollDirection = Axis.vertical,
  })  : assert(decimalPlaces > 0),
        assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        selectedIntValue = initialValue.floor(), // Added () here
        selectedDecimalValue = -1,
        intScrollController = null,
        decimalScrollController = null,
        _listViewHeight = 3 * itemExtent,
        step = 1;

  final ValueChanged<num> onChanged;
  final int minValue;
  final int maxValue;
  final int decimalPlaces;
  final double itemExtent;
  final double _listViewHeight;
  final double listViewWidth;
  final ScrollController? intScrollController;
  final ScrollController? decimalScrollController;
  final int selectedIntValue;
  final int? selectedDecimalValue;
  final int step;
  final Axis scrollDirection;
}
