import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_timer/data/task_manager.dart';
import 'package:flutter_timer/pages/home_page/home_state.dart';
import 'package:flutter_timer/pages/home_page/home_events.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TaskManager taskManager;

  HomeBloc({required this.taskManager}) : super(const HomeStateLoading()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<SaveTaskEvent>(_onSaveTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(LoadTasksEvent event, Emitter<HomeState> emit) async {
    emit(const HomeStateLoading());
    final data = await taskManager.loadAllTasks();
    emit(HomeStateLoaded(tasks: data));
  }

  Future<void> _onSaveTask(SaveTaskEvent event, Emitter<HomeState> emit) async {
    emit(const HomeStateLoading());
    await taskManager.addNewTask(event.task);
    
    add(const LoadTasksEvent());
  }

  Future<void> _onDeleteTask(DeleteTaskEvent event, Emitter<HomeState> emit) async {
    await taskManager.deleteTask(event.task);
    add(const LoadTasksEvent());
  }
}