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
      child: InkWell(
        onTap: () => _startTimerPage(context, task),
        borderRadius: _borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 12.0),
                width: 15.0,
                height: 15.0,
                decoration: BoxDecoration(
                  color: task.color,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      task.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Duration: ${_formatDuration()}',
                      style: const TextStyle(color: Colors.black54, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.navigate_next,
                color: task.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}