import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../core/theme/app_theme.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

class StraightPathApp extends StatelessWidget {
  const StraightPathApp({super.key});

  @override
  Widget build(BuildContext context) {
    const initialRoute = String.fromEnvironment(
      'INITIAL_ROUTE',
      defaultValue: AppRoutes.splash,
    );

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return GetMaterialApp(
      title: 'Straight Path',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: initialRoute,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 260),
    );
  }
}
