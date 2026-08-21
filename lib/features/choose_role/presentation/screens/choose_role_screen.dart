import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../generated/image_assets.dart';
import '../widgets/role_selection_card_widget.dart';

class ChooseRoleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChooseRoleScreen();
}

class _ChooseRoleScreen extends State<ChooseRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TopLeftShadowWidget(),
          BottomRightShadowWidget(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  HeightSpace(32),
                  Image.asset(ImageAssets.appLogo),
                  Text("Doctor Hunt", style: AppTextStyles.titleTextStyle),
                  HeightSpace(55),
                  Text("Choose your role", style: AppTextStyles.rubik28regular),
                  HeightSpace(10),
                  Text(
                    "The selected role determines the experience and available features.",
                    style: AppTextStyles.subTitleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  HeightSpace(30),
                  RoleSelectionCardWidget(
                    title: 'Patient',
                    description:
                        'Find doctors, book appointments, and manage your medical records.',
                    roleIcon: Icons.personal_injury_rounded,
                    isSelected: true,
                    onTap: () {},
                  ),
                  HeightSpace(16),
                  RoleSelectionCardWidget(
                    title: 'Admin',
                    description:
                        'Manage doctors, appointments, users, and the platform.',
                    roleIcon: Icons.grid_view_outlined,
                    isSelected: false,
                    onTap: () {},
                  ),
                  Spacer(),
                  CustomElevatdButton(
                    buttonTXT: "Continue",
                    onTap: () {
                      LoginRoute().go(context);
                      //GoRouter.of(context,).pushNamed(AppRoutes.loginScreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
