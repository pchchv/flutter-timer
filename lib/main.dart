import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/data/task_manager.dart';
import 'package:flutter_timer/pages/home_page/home_bloc.dart';

class MyApp extends StatelessWidget {
  final TaskManager taskManager;

  const MyApp({super.key, required this.taskManager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
    );
  }
}