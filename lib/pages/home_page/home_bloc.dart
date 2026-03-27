import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_timer/data/task_manager.dart';
import 'package:flutter_timer/pages/home_page/home_state.dart';
import 'package:flutter_timer/pages/home_page/home_events.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TaskManager taskManager;

  Future<void> _onLoadTasks(LoadTasksEvent event, Emitter<HomeState> emit) async {
    emit(const HomeStateLoading());
    final data = await taskManager.loadAllTasks();
    emit(HomeStateLoaded(tasks: data));
  }
}