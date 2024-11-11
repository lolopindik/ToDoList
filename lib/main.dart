import 'package:bloc_to_do/logic/bloc/bloc_obrever.dart';
// import 'package:bloc_to_do/logic/funcs/uuid.dart';
import 'package:bloc_to_do/presentation/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = AppBlocObserver();

  //*Test uuid class
  // var subId = ConcreteSubID();
  // subId.printUuid(); 

  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
