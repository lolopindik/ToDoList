import 'dart:io';

import 'package:buzz_tech/logic/bloc/bloc_obrever.dart';
import 'package:buzz_tech/logic/services/notification_service.dart';
import 'package:buzz_tech/presentation/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badge_control/flutter_app_badge_control.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();

  (Platform.isAndroid)
      ? await NotificationService().requestNotificationPermission()
      : debugPrint('The IOS itself requires permission');

  FlutterAppBadgeControl.updateBadgeCount(0);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = AppBlocObserver();

  runApp(MyApp());
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
