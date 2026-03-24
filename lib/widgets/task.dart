import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_timer/model/task.dart';
import 'package:flutter_timer/pages/timer.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  final Task task;
  final BorderRadius _borderRadius = const BorderRadius.all(Radius.circular(8.0));

  String _formatDuration() {
    final h = task.hours.toString().padLeft(2, '0');
    final m = task.minutes.toString().padLeft(2, '0');
    final s = task.seconds.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  void _startTimerPage(BuildContext context, Task task) {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (_) => TimerPage(task: task),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
    );
  }
}