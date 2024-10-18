import 'package:bloc_to_do/logic/bloc/DatePicker/datepicker_bloc.dart';
import 'package:bloc_to_do/logic/bloc/TimePicker/timepicker_bloc.dart';
import 'package:bloc_to_do/presentation/animations/transition_animation.dart';
import 'package:bloc_to_do/presentation/screens/home_screen.dart';
import 'package:bloc_to_do/presentation/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/add_task':
        return TransitionAnimation.createRoute(MultiBlocProvider(providers: [
          BlocProvider(create: (context) => DatepickerBloc()),
          BlocProvider(create: (context) => TimepickerBloc())
        ], child: const TaskScreen()));
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}
