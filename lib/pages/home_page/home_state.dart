import 'package:equatable/equatable.dart';

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