import 'package:equatable/equatable.dart';

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