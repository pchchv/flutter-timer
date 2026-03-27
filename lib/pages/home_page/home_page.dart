import 'package:flutter/material.dart';
import 'package:flutter_timer/model/task.dart';
import 'package:flutter_timer/pages/new_task.dart';
import 'package:flutter_timer/pages/home_page/home_bloc.dart';
import 'package:flutter_timer/pages/home_page/home_events.dart';

class HomePage extends StatefulWidget {
  final String title = 'Task Timer';
  final HomeBloc homeBloc;

  const HomePage({super.key, required this.homeBloc});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openBottomSheet() async {
    final newTask = await showModalBottomSheet<Task>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: const NewTaskPage(),
        );
      },
    );

    if (newTask != null) {
      widget.homeBloc.add(SaveTaskEvent(task: newTask));
    }
  }

  @override
  void initState() {
    super.initState();
    widget.homeBloc.add(const LoadTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black, 
            fontSize: 32.0, 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _openBottomSheet,
        child: const Icon(Icons.add, size: 26, color: Colors.black),
      ),
    );
  }
}