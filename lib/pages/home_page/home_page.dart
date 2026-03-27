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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    );
  }
}