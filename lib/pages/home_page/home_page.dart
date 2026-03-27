import 'package:flutter/material.dart';
import 'package:flutter_timer/pages/home_page/home_bloc.dart';

class HomePage extends StatefulWidget {
  final String title = 'Task Timer';
  final HomeBloc homeBloc;

  const HomePage({super.key, required this.homeBloc});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
}