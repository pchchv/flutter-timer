import 'package:flutter/material.dart';

class Task {
  final int id;
  final Color color;
  final String title;
  final int hours, minutes, seconds;

  Task({
    this.id = 0,
    required this.color,
    required this.title,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  factory Task.fromMap(Map<String, dynamic> json) => Task(
      id: json['id'] ?? 0,
      color: Color(json['color']),
      title: json['title'],
      hours: json['hours'],
      minutes: json['minutes'],
      seconds: json['seconds'],
  );
}