import 'dart:ui';

import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_color_shape.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_elevated_button.dart';
import '../../data/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingScreen();
}

class _OnboardingScreen extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TopLeftColorShape(),
          BottomRightShadowWidget(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: PageView.builder(
                controller: _pageController,
                itemCount: OnboardingModel.onboardingPages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeightSpace(70),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(160.0.r),
                        child: Image.asset(
                          OnboardingModel.onboardingPages[index].image,
                          width: 336.w,
                          height: 336.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      HeightSpace(65),
                      Text(
                        OnboardingModel.onboardingPages[index].title,
                        style: context.bold26TextMain,
                      ),
                      HeightSpace(11),
                      Text(
                        OnboardingModel
                            .onboardingPages[_currentIndex]
                            .description,
                        style: context.regular14TextSub,
                        textAlign: TextAlign.center,
                      ),
                      HeightSpace(35),
                      CustomElevatdButton(
                        buttonTXT: "Get Started",
                        onTap: () {
                          if (_currentIndex <
                              (OnboardingModel.onboardingPages.length - 1)) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            ChooseRoleRoute().go(context);
                            //GoRouter.of(context,).pushNamed(AppRoutes.chooseRoleScreen);
                          }
                        },
                      ),
                      HeightSpace(10),
                      TextButton(
                        onPressed: () {
                          // GoRouter.of(
                          //   context,
                          // ).pushNamed(AppRoutes.chooseRoleScreen);
                          ChooseRoleRoute().go(context);
                        },
                        child: Text(
                          "Skip",
                          style: context.regular14TextSub,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
