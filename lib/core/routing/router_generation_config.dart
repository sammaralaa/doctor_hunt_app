import 'package:doctor_hunt_app/core/routing/app_routs.dart';
import 'package:doctor_hunt_app/features/auth/presentation/screens/Sign_up_screen.dart';
import 'package:doctor_hunt_app/features/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt_app/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:doctor_hunt_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.splashScreen,
      routes: [
        GoRoute(
            path: AppRoutes.splashScreen,
          name: AppRoutes.splashScreen,
          builder: (context,state) => const SplashScreen()
        ),
        GoRoute(
          path: AppRoutes.onBoardingScreen,
          name: AppRoutes.onBoardingScreen,
          builder: (context, state) => OnboardingScreen(),
        ),
        GoRoute(
          path: AppRoutes.loginScreen,
          name: AppRoutes.loginScreen,
          builder: (context, state) => LoginScreen(),
        ),
        GoRoute(
          path: AppRoutes.signupScreen,
          name: AppRoutes.signupScreen,
          builder: (context, state) => SignUpScreen(),
        ),
        GoRoute(
          path: AppRoutes.chooseRoleScreen,
          name: AppRoutes.chooseRoleScreen,
          builder: (context, state) => ChooseRoleScreen(),
        ),
      ]);
}