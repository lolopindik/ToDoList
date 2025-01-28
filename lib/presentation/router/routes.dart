import 'package:buzz_tech/logic/bloc/CategoryPicker/categorypicker_cubit.dart';
import 'package:buzz_tech/logic/bloc/CheckBox/check_box_bloc.dart';
import 'package:buzz_tech/logic/bloc/ComapeData/comapre_data_bloc.dart';
import 'package:buzz_tech/logic/bloc/CompareTask/compare_task_bloc.dart';
import 'package:buzz_tech/logic/bloc/DataCollection/data_collection_bloc.dart';
import 'package:buzz_tech/logic/bloc/DatePicker/datepicker_bloc.dart';
import 'package:buzz_tech/logic/bloc/TextFieldHandler/text_field_handler_bloc.dart';
import 'package:buzz_tech/logic/bloc/TimePicker/timepicker_bloc.dart';
import 'package:buzz_tech/logic/funcs/get_json.dart';
import 'package:buzz_tech/presentation/animations/transition_animation.dart';
import 'package:buzz_tech/presentation/screens/details_screen.dart';
import 'package:buzz_tech/presentation/screens/edit_task_screen.dart';
import 'package:buzz_tech/presentation/screens/home_screen.dart';
import 'package:buzz_tech/presentation/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return _buildHomeRoute();
      case '/details':
        return _buildDetailsRoute(routeSettings);
      case '/add_task':
        return _buildAddTaskRoute();
      case '/edit_task':
        return _buildEditTaskRoute(routeSettings);
      default:
        return _buildHomeRoute();
    }
  }

  Route _buildHomeRoute() {
    return TransitionAnimation.createRoute(
      MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => ComapreDataBloc(GetJson())..fetchData()),
          BlocProvider(
              create: (context) =>
                  CheckBoxBloc(context.read<ComapreDataBloc>())),
        ],
        child: const HomeScreen(),
      ),
    );
  }

  Route _buildDetailsRoute(RouteSettings routeSettings) {
    if (routeSettings.arguments is! Map<String, dynamic>) {
      throw FlutterError('Invalid arguments for /details route');
    }
    final args = routeSettings.arguments as Map<String, dynamic>;
    final String taskId = args['taskId'];
    final Offset tapPosition = args['tapPosition'];

    return DetailsTransitionAnimation.createRoute(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                CompareTaskBloc(GetJson())..fetchTaskById(taskId),
          ),
        ],
        child: const DetailsScreen(),
      ),
      tapPosition,
    );
  }

  Route _buildAddTaskRoute() {
    return TransitionAnimation.createRoute(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DatepickerBloc()),
          BlocProvider(create: (context) => TimepickerBloc()),
          BlocProvider(create: (context) => TextFieldHandlerBloc()),
          BlocProvider(create: (context) => CategorypickerCubit()),
          BlocProvider(
            create: (context) => DataCollectionBloc(
              context.read<CategorypickerCubit>(),
              context.read<DatepickerBloc>(),
              context.read<TextFieldHandlerBloc>(),
              context.read<TimepickerBloc>(),
            ),
          ),
        ],
        child: const TaskScreen(),
      ),
    );
  }

  Route _buildEditTaskRoute(RouteSettings routeSettings) {
    if (routeSettings.arguments is! Map<String, dynamic>) {
      throw FlutterError('Invalid arguments for /edit_task route');
    }
    final task = routeSettings.arguments as Map<String, dynamic>;

    return TransitionAnimation.createRoute(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DatepickerBloc()),
          BlocProvider(create: (context) => TimepickerBloc()),
          BlocProvider(create: (context) => TextFieldHandlerBloc()),
          BlocProvider(create: (context) => CategorypickerCubit()),
          BlocProvider(
            create: (context) => DataCollectionBloc(
              context.read<CategorypickerCubit>(),
              context.read<DatepickerBloc>(),
              context.read<TextFieldHandlerBloc>(),
              context.read<TimepickerBloc>(),
            ),
          ),
        ],
        child: EditTask(task: task),
      ),
    );
  }
}
