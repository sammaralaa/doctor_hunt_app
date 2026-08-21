import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


void main() {
  runApp(const MyApp());
}
final GoRouter _router = GoRouter(
  initialLocation: '/', 
  routes: $appRoutes,  
);
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      ensureScreenSize: true,
      builder: (context,child){
        return MaterialApp.router(
          title: 'Doctor Hunt',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            fontFamily: 'Rubik'
        ),
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        );
      },
    );

  }
}

