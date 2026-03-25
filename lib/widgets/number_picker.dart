import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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

  // --- Animations ---

  void animateInt(int valueToSelect) {
    int diff = valueToSelect - minValue;
    int index = diff ~/ step;
    _animate(intScrollController, index * itemExtent);
  }

  void animateDecimal(int decimalValue) {
    _animate(decimalScrollController, decimalValue * itemExtent);
  }

  void animateDecimalAndInteger(double valueToSelect) {
    animateInt(valueToSelect.floor());
    animateDecimal(((valueToSelect - valueToSelect.floorToDouble()) *
            math.pow(10, decimalPlaces))
        .round());
  }

  void _animate(ScrollController? scrollController, double value) {
    scrollController?.animateTo(
      value,
      duration: const Duration(seconds: 1),
      curve: const ElasticOutCurve(),
    );
  }

  // --- Build Logic ---

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (decimalPlaces == 0) {
      return _integerListView(theme);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _integerListView(theme),
          _decimalListView(theme),
        ],
      );
    }
  }

  Widget _integerListView(ThemeData theme) {
    final TextStyle defaultStyle = theme.textTheme.bodyMedium!;
    final TextStyle selectedStyle = theme.textTheme.headlineMedium!.copyWith(
      color: theme.colorScheme.primary,
    );

    int itemCount = (maxValue - minValue) ~/ step + 3;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => _onIntegerNotification(notification),
      child: SizedBox(
        height: _listViewHeight / 3,
        width: listViewWidth,
        child: ListView.builder(
          scrollDirection: scrollDirection,
          controller: intScrollController,
          itemExtent: itemExtent,
          itemCount: itemCount,
          cacheExtent: _calculateCacheExtent(itemCount),
          itemBuilder: (context, index) {
            final int value = _intValueFromIndex(index);
            final bool isExtra = index == 0 || index == itemCount - 1;

            if (isExtra) return const SizedBox.shrink();

            final TextStyle itemStyle =
                value == selectedIntValue ? selectedStyle : defaultStyle;

            return Center(
              child: Text(value.toString(), style: itemStyle),
            );
          },
        ),
      ),
    );
  }

  Widget _decimalListView(ThemeData theme) {
    final TextStyle defaultStyle = theme.textTheme.bodyMedium!;
    final TextStyle selectedStyle = theme.textTheme.headlineMedium!.copyWith(
      color: theme.colorScheme.primary,
    );
    final int decimalRange = math.pow(10, decimalPlaces).toInt();
    final int itemCount = selectedIntValue == maxValue ? 3 : decimalRange + 2;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => _onDecimalNotification(notification),
      child: SizedBox(
        height: _listViewHeight,
        width: listViewWidth,
        child: ListView.builder(
          controller: decimalScrollController,
          itemExtent: itemExtent,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            final int value = index - 1;
            final bool isExtra = index == 0 || index == itemCount - 1;

            if (isExtra) return const SizedBox.shrink();

            final TextStyle itemStyle = value == selectedDecimalValue ? selectedStyle : defaultStyle;

            return Center(
              child: Text(
                value.toString().padLeft(decimalPlaces, '0'),
                style: itemStyle,
              ),
            );
          },
        ),
      ),
    );
  }

  // --- Helpers & Notifications ---

  int _intValueFromIndex(int index) => minValue + (index - 1) * step;

  bool _onIntegerNotification(ScrollNotification notification) {
    final double centerOffset = notification.metrics.pixels + (_listViewHeight / 2);
    final int indexOfMiddle = centerOffset ~/ itemExtent;
    int valueInMiddle = _intValueFromIndex(indexOfMiddle);
    valueInMiddle = _normalizeIntegerMiddleValue(valueInMiddle);

    if (_userStoppedScrolling(notification, intScrollController)) {
      animateInt(valueInMiddle);
    }

    if (valueInMiddle != selectedIntValue) {
      num newValue;
      if (decimalPlaces == 0) {
        newValue = valueInMiddle;
      } else {
        if (valueInMiddle == maxValue) {
          newValue = valueInMiddle.toDouble();
          animateDecimal(0);
        } else {
          final double decimalPart = _toDecimal(selectedDecimalValue ?? 0);
          newValue = valueInMiddle + decimalPart;
        }
      }
      onChanged(newValue);
    }
    return true;
  }

  bool _onDecimalNotification(ScrollNotification notification) {
    final double centerOffset = notification.metrics.pixels + (_listViewHeight / 2);
    final int decimalValueInMiddle = (centerOffset ~/ itemExtent) - 1;
    final int normalizedValue = _normalizeDecimalMiddleValue(decimalValueInMiddle);

    if (_userStoppedScrolling(notification, decimalScrollController)) {
      animateDecimal(normalizedValue);
    }

    if (selectedIntValue != maxValue && normalizedValue != selectedDecimalValue) {
      final double decimalPart = _toDecimal(normalizedValue);
      final double newValue = selectedIntValue + decimalPart;
      onChanged(newValue);
    }
    return true;
  }

  double _calculateCacheExtent(int itemCount) {
    double cacheExtent = 250.0;
    if ((itemCount - 2) * defaultItemExtent <= cacheExtent) {
      cacheExtent = ((itemCount - 3) * defaultItemExtent);
    }
    return cacheExtent;
  }

  int _normalizeMiddleValue(int value, int min, int max) {
    return math.max(math.min(value, max), min);
  }

  int _normalizeIntegerMiddleValue(int value) {
    final int max = (maxValue ~/ step) * step;
    return _normalizeMiddleValue(value, minValue, max);
  }

  int _normalizeDecimalMiddleValue(int value) {
    final int max = math.pow(10, decimalPlaces).toInt() - 1;
    return _normalizeMiddleValue(value, 0, max);
  }

  bool _userStoppedScrolling(ScrollNotification notification, ScrollController? controller) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        controller != null;
  }

  double _toDecimal(int decimalValueAsInteger) {
    return double.parse(
      (decimalValueAsInteger * math.pow(10, -decimalPlaces))
          .toStringAsFixed(decimalPlaces),
    );
  }
}

/// Returns AlertDialog as a Widget designed to be used in showDialog method.
class NumberPickerDialog extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int? initialIntegerValue;
  final double? initialDoubleValue;
  final int decimalPlaces;
  final Widget? title;
  final EdgeInsets? titlePadding;
  final Widget confirmWidget;
  final Widget cancelWidget;
  final int step;

  const NumberPickerDialog.integer({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.initialIntegerValue,
    this.title,
    this.titlePadding,
    this.step = 1,
    Widget? confirmWidget,
    Widget? cancelWidget,
  })  : confirmWidget = confirmWidget ?? const Text("OK"),
        cancelWidget = cancelWidget ?? const Text("CANCEL"),
        decimalPlaces = 0,
        initialDoubleValue = null;

  @override
  State<NumberPickerDialog> createState() => _NumberPickerDialogState();
}

class _NumberPickerDialogState extends State<NumberPickerDialog> {
  late int selectedIntValue;
  late double selectedDoubleValue;
}
