import 'dart:ui';

import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/features/splash/presentation/controller/splash_bloc.dart';
import 'package:doctor_hunt_app/features/splash/presentation/controller/splash_event.dart';
import 'package:doctor_hunt_app/features/splash/presentation/controller/splash_state.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //_navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      //context.go(AppRoutes.onBoardingScreen);
      // context.pushReplacementNamed(Routes.homeScreen);
      //GoRouter.of(context,).pushNamed(AppRoutes.forgetPasswordScreen);
      OnBoardingRoute().go(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(CheckInitialRouteEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is NavigateToOnboarding) {
            OnBoardingRoute().go(context);
          } else if (state is NavigateToLogin) {
            LoginRoute().go(
              context,
            ); 
          } else if (state is NavigateToAdminHome) {
            AdminMainRoute().go(
              context,
            ); 
          } else if (state is NavigateToPatientHome) {
            MainScreenRoute().go(
              context,
            ); 
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              TopLeftShadowWidget(),
              BottomRightShadowWidget(),
              SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/app_logo.png"),
                      HeightSpace(11),
                      Text("Doctor Hunt", style: context.bold26TextMain),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
