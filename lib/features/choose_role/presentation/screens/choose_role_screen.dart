import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

import '../../../../generated/image_assets.dart';
import '../widgets/role_selection_card_widget.dart';

enum UserRole { patient, admin }

class ChooseRoleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChooseRoleScreen();
}

class _ChooseRoleScreen extends State<ChooseRoleScreen> {
  UserRole _selectedRole = UserRole.patient;
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
                  Text(t.doctor_hunt, style: context.bold26TextMain),
                  HeightSpace(55),
                  Text(t.chooseYourRole, style: context.regular28TextMain),
                  HeightSpace(10),
                  Text(
                    t.theSelectedRoleDetermines,
                    style: context.regular14TextSub,
                    textAlign: TextAlign.center,
                  ),
                  HeightSpace(30),
                  RoleSelectionCardWidget(
                    title: t.patient,
                    description: t.patientRoleDescreption,
                    roleIcon: Icons.personal_injury_rounded,
                    isSelected: _selectedRole == UserRole.patient,
                    onTap: () {
                      setState(() {
                        _selectedRole = UserRole.patient;
                      });
                    },
                  ),
                  HeightSpace(16),
                  RoleSelectionCardWidget(
                    title: t.admin,
                    description: t.adminRoleDescription,
                    roleIcon: Icons.grid_view_outlined,
                    isSelected: _selectedRole == UserRole.admin,
                    onTap: () {
                      setState(() {
                        _selectedRole = UserRole.admin;
                      });
                    },
                  ),
                  Spacer(),
                  CustomElevatdButton(
                    onTap: () {
                      print(_selectedRole.name);
                      SignUpRoute(userRole: _selectedRole.name).go(context);
                      //LoginRoute().go(context);
                      // AdminMainRoute().go(context);
                      //GoRouter.of(context,).pushNamed(AppRoutes.loginScreen);
                    },
                    buttonTXT: t.kContinue,
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
