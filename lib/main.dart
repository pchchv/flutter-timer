import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/data/task_manager.dart';
import 'package:flutter_timer/pages/home_page/home_bloc.dart';
import 'package:flutter_timer/pages/home_page/home_events.dart';

class TimerApp extends StatelessWidget {
  final TaskManager taskManager;

  const TimerApp({super.key, required this.taskManager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      // Create the Bloc and immediately trigger the load event
      create: (context) => HomeBloc(taskManager: taskManager)..add(const LoadTasksEvent()),
    );
  }
}