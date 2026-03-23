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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
      ),
    );
  }
}