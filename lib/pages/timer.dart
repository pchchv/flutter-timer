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
  
  // 50ms is plenty for a smooth UI update without taxing the CPU
  static const delay = Duration(milliseconds: 50);

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

  void updateClock() {
    final totalDuration = Duration(
      hours: widget.task.hours, 
      minutes: widget.task.minutes, 
      seconds: widget.task.seconds
    );

    // Completion Logic
    if (stopwatch.elapsed >= totalDuration) {
      stopwatch.stop();
      _controller.stop();
      setState(() {
        statusText = 'Finished';
        buttonText = "Restart";
      });
      _formatTime();
      return;
    }

    _formatTime();

    // Update Button State
    setState(() {
      if (stopwatch.isRunning) {
        buttonText = "Running";
        statusText = '';
      } else if (stopwatch.elapsed.inMilliseconds == 0) {
        buttonText = "Start";
      } else {
        buttonText = "Paused";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    
    final duration = Duration(
      hours: widget.task.hours, 
      minutes: widget.task.minutes, 
      seconds: widget.task.seconds
    );

    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );

    // Initial text setup
    _formatTime();
    
    // Start the periodic UI refresh
    timer = Timer.periodic(delay, (Timer t) => updateClock());
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tween setup that updates with the controller
    final heightAnimation = Tween(begin: begin, end: MediaQuery.of(context).size.height - 65)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
      ),
    );
  }
}