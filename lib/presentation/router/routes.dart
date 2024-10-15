import 'package:bloc_to_do/presentation/animations/transition_animation.dart';
import 'package:bloc_to_do/presentation/screens/home_screen.dart';
import 'package:bloc_to_do/presentation/screens/task_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/add_task':
        return TransitionAnimation.createRoute(const TaskScreen());
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}
