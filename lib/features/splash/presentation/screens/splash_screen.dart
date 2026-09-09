import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/services/shared_prefs_service.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SharedPrefsService.init();
    _navigateToHome();
  }
  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      if (SharedPrefsService.getBool('is_first_time') == true || SharedPrefsService.getBool('is_first_time') == null) {
        SharedPrefsService.setBool('is_first_time', false);
        OnBoardingRoute().go(context);
      }
      if (SharedPrefsService.getBool('is_logged_in') == true) {
        MainScreenRoute().go(context);
      } else {
        ChooseRoleRoute().go(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          TopLeftShadowWidget(),
          BottomRightShadowWidget(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageAssets.appLogo),
              HeightSpace(11),
              Text(t.doctor_hunt, style: context.bold26TextMain),
            ],
          ),
        ],
      ),
    );
  }
}
