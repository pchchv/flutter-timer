import 'package:equatable/equatable.dart';
import 'package:flutter_timer/model/task.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeStateLoading extends HomeState {
  const HomeStateLoading();

  @override
  String toString() => 'HomeStateLoading';
}

class HomeStateLoaded extends HomeState {
  final List<Task> tasks;

  const HomeStateLoaded({required this.tasks});

  @override
  List<Object?> get props => [tasks];

  @override
  String toString() => 'HomeStateLoaded { tasks: ${tasks.length} }';
}