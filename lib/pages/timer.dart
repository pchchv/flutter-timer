import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_timer/model/task.dart';

class TimerPage extends StatefulWidget {
  final Task task;

  const TimerPage({Key? key, required this.task}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with SingleTickerProviderStateMixin {
  late Timer timer;
  final Stopwatch stopwatch = Stopwatch();

  String timeText = '';
  String statusText = '';
  String buttonText = 'Start';

  late AnimationController _controller;
  double begin = 0.0;

  void _formatTime() {
    final totalDuration = Duration(
      hours: widget.task.hours, 
      minutes: widget.task.minutes, 
      seconds: widget.task.seconds
    );
    
    final remaining = totalDuration - stopwatch.elapsed;
    final displayTime = remaining.inMilliseconds > 0 ? remaining : Duration.zero;
    final hours = displayTime.inHours.toString().padLeft(2, '0');
    final minutes = (displayTime.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (displayTime.inSeconds % 60).toString().padLeft(2, '0');
    setState(() {
      timeText = '$hours:$minutes:$seconds';
    });
  }

  void _restartCountDown() {
    setState(() {
      begin = 0.0;
      statusText = '';
      buttonText = 'Start';
    });
    _controller.reset();
    stopwatch.stop();
    stopwatch.reset();
    _formatTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
      ),
    );
  }
}