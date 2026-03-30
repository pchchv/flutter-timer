import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer/pages/splash.dart';
import 'package:flutter_timer/pages/new_task.dart';
import 'package:flutter_timer/data/task_manager.dart';
import 'package:flutter_timer/pages/home_page/home_bloc.dart';
import 'package:flutter_timer/pages/home_page/home_page.dart';
import 'package:flutter_timer/pages/home_page/home_events.dart';

final logger = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class TimerApp extends StatelessWidget {
  final TaskManager taskManager;

  const TimerApp({super.key, required this.taskManager});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      // Create the Bloc and immediately trigger the load event
      create: (context) => HomeBloc(taskManager: taskManager)..add(const LoadTasksEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
        ),
        // Start with the SplashPage
        home: const SplashPage(),
        routes: <String, WidgetBuilder>{
          '/home': (context) => HomePage(homeBloc: context.read<HomeBloc>()),
          '/new': (context) => const NewTaskPage(),
        },
      ),
    );
  }
}

// Bloc Observer for logging transitions
class Observer extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.i('Transition in ${bloc.runtimeType}: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('Error in ${bloc.runtimeType}', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}