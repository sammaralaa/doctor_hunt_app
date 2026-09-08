import 'package:doctor_hunt_app/features/splash/presentation/controller/splash_bloc.dart';
import 'package:doctor_hunt_app/features/splash/presentation/controller/splash_event.dart';
import 'package:doctor_hunt_app/features/splash/presentation/controller/splash_state.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(CheckInitialRouteEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          // if (state is NavigateToOnboarding) {
          //   OnBoardingRoute().go(context);
          // } else if (state is NavigateToLogin) {
          //   LoginRoute().go(
          //     context,
          //   );
          // } else if (state is NavigateToAdminHome) {
          //   AdminMainRoute().go(
          //     context,
          //   );
          // } else if (state is NavigateToPatientHome) {
          //   MainScreenRoute().go(
          //     context,
          //   );
          // }
        },
        child: Scaffold(
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
        ),
      ),
    );
  }
}
