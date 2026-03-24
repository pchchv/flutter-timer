import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer/model/task.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  String _formatDuration() {
    final h = task.hours.toString().padLeft(2, '0');
    final m = task.minutes.toString().padLeft(2, '0');
    final s = task.seconds.toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}