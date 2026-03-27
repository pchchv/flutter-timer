import 'dart:async';
import 'package:flutter_timer/model/task.dart';
import 'package:flutter_timer/data/database.dart';

class TaskManager {
  final DatabaseProvider dbProvider;

  const TaskManager({required this.dbProvider});

  Future<int> addNewTask(Task task) async {
    return await dbProvider.insert(task);
  }

  Future<List<Task>> loadAllTasks() async {
    return await dbProvider.getAll();
  }
}