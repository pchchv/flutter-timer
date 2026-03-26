import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_timer/model/task.dart';

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

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  late TextEditingController _titleController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static const int maxHours = 24;
  static const int maxMinutes = 60;
  static const int maxSeconds = 60;
  static const int _maxTitleLength = 30;

  int _selectedHour = 0;
  int _selectedMinute = 0;
  int _selectedSecond = 0;

  Color getRandomColor() {
    final Random r = Random();
    final colorsList = Colors.primaries;
    return colorsList[r.nextInt(colorsList.length)];
  }

  void _saveTaskAndClose() {
    if (_formKey.currentState?.validate() ?? false) {
      final color = getRandomColor();
      final task = Task(
        color: color,
        title: _titleController.text,
        hours: _selectedHour,
        minutes: _selectedMinute,
        seconds: _selectedSecond,
      );

      Navigator.of(context).pop(task);
    }
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        height: 450,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: TextFormField(
                maxLength: _maxTitleLength,
                controller: _titleController,
                style: const TextStyle(fontSize: 24.0, color: Colors.black),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Task title is required.';
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Task Title',
                  filled: true,
                  fillColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Duration',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                _buildPicker('hours', maxHours, (val) => _selectedHour = val, "hours"),
                _buildPicker('minutes', maxMinutes, (val) => _selectedMinute = val, "min"),
                _buildPicker('seconds', maxSeconds, (val) => _selectedSecond = val, "sec"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper to keep the build method clean.
  Widget _buildPicker(String key, int max, Function(int) onChanged, String label) {
    return Expanded(
      child: SizedBox(
        key: ObjectKey(key),
        height: 110,
        child: _Selector<int>(
          items: List.generate(max, (i) => i),
          itemBuilder: (i) => "$i $label",
          onSelectedItemChanged: (val) => onChanged(val),
        ),
      ),
    );
  }
}