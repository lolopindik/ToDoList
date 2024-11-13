import 'package:bloc_to_do/logic/bloc/CategoryPicker/categorypicker_cubit.dart';
import 'package:bloc_to_do/logic/bloc/CheckBox/check_box_bloc.dart';
import 'package:bloc_to_do/logic/bloc/ComapeData/comapre_data_bloc.dart';
import 'package:bloc_to_do/logic/bloc/CompareTask/compare_task_bloc.dart';
import 'package:bloc_to_do/logic/bloc/DataCollection/data_collection_bloc.dart';
import 'package:bloc_to_do/logic/bloc/DataTransfer/data_transfer_bloc.dart';
import 'package:bloc_to_do/logic/bloc/DatePicker/datepicker_bloc.dart';
import 'package:bloc_to_do/logic/bloc/TextFieldHandler/text_field_handler_bloc.dart';
import 'package:bloc_to_do/logic/bloc/TimePicker/timepicker_bloc.dart';
import 'package:bloc_to_do/logic/funcs/get_json.dart';
import 'package:bloc_to_do/presentation/animations/transition_animation.dart';
import 'package:bloc_to_do/presentation/screens/details_screen.dart';
import 'package:bloc_to_do/presentation/screens/home_screen.dart';
import 'package:bloc_to_do/presentation/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) =>
                            ComapreDataBloc(GetJson())..fetchData()),
                    BlocProvider(create: (context) => CheckBoxBloc())
                  ],
                  child: const HomeScreen(),
                ));
      case '/details':
        final String taskId = routeSettings.arguments as String;

        return MaterialPageRoute(
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      CompareTaskBloc(GetJson())..fetchTaskById(taskId),
                ),
                BlocProvider(
                  create: (context) =>
                      DataTransferBloc()..add(DataTransferEvent(taskId)),
                ),
              ],
              child: const DetailsScreen(),
            );
          },
        );
      case '/add_task':
        return TransitionAnimation.createRoute(MultiBlocProvider(
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
        ));
      default:
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (context) =>
                            ComapreDataBloc(GetJson())..fetchData()),
                    BlocProvider(create: (context) => CheckBoxBloc())
                  ],
                  child: const HomeScreen(),
                ));
    }
  }
}
