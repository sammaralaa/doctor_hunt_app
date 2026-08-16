import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/theme/app_text_styles.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/auth/presentation/widgets/custom_textfeild_widget.dart';
import 'package:doctor_hunt_app/features/auth/presentation/widgets/login_with_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/app_routs.dart';
import '../widgets/forgot_password_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  bool ispassword = true;
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passController;
  bool isAccepted = false;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

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
                  HeightSpace(100),
                  Text(
                    "Welcome back",
                    style: AppTextStyles.titleTextStyle,
                  ),
                  HeightSpace(15),
                  Text(
                    "You can search c ourse, apply course and findscholarship for abroad studies",
                    style: AppTextStyles.subTitleTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  HeightSpace(60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LoginWithWidget(
                        btnText: "Google",
                        onTop: () {},
                        btnIcon: SvgPicture.asset(
                          "assets/icons/google_icon.svg",
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                      WidthSpace(15),
                      LoginWithWidget(
                        btnText: "Facebook",
                        onTop: () {},
                        btnIcon: SvgPicture.asset(
                          "assets/icons/facebook_icon.svg",
                          width: 20.w,
                          height: 20.h,
                        ),
                      ),
                    ],
                  ),
                  HeightSpace(34),
                  CustomTextfeildWidget(hintText: "Email"),
                  HeightSpace(18),
                  CustomTextfeildWidget(hintText: "Password"),
                  HeightSpace(32),
                  CustomElevatdButton(buttonTXT: "Sign up", onTap: () {}),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30.r),
                          ),
                        ),
                        builder: (context) =>  ForgotPasswordWidget(),
                      );
                    },
                    child: Text(
                      "Forgor password",
                      style: AppTextStyles.subTitleTextStyle.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an account?",
                        style: AppTextStyles.subTitleTextStyle.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context,).pushNamed(AppRoutes.signupScreen);
                        },
                        child: Text(
                          "Join us",
                          style: AppTextStyles.subTitleTextStyle.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
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
