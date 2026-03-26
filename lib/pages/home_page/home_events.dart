import 'package:equatable/equatable.dart';
import 'package:flutter_timer/model/task.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasksEvent extends HomeEvent {
  const LoadTasksEvent();

  @override
  String toString() => 'LoadTasksEvent';
}

class SaveTaskEvent extends HomeEvent {
  final Task task;

  const SaveTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];

  @override
  String toString() => 'SaveTaskEvent { task: ${task.title} }';
}

class DeleteTaskEvent extends HomeEvent {
  final Task task;

  const DeleteTaskEvent({required this.task});

  @override
  List<Object?> get props => [task];

  @override
  String toString() => 'DeleteTaskEvent { task: ${task.title} }';
}