import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/bottom_right_shadow_widget.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../../../../core/widgets/top_left_shadow_widget.dart';
import '../widgets/custom_textfeild_widget.dart';
import '../widgets/login_with_widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> {
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
  Widget build(BuildContext context){
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
                    "Join us to start searching",
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
                  CustomTextfeildWidget(hintText: "Name"),
                  HeightSpace(18),
                  CustomTextfeildWidget(hintText: "Email"),
                  HeightSpace(18),
                  CustomTextfeildWidget(hintText: "Password"),
                  HeightSpace(14),
                  Row(
                    children: [
                      Checkbox(
                        value: isAccepted,
                        shape: const CircleBorder(),
                        activeColor: AppColors.primaryColor,
                        side: const BorderSide(
                          color: Color(0xFF677294), // Inactive Border Color
                          width: 1.5,
                        ),
                        onChanged: (bool? value) {
                          setState(() {
                            isAccepted = value ?? false;
                          });
                        },
                      ),
                      WidthSpace(11),
                      Text(
                        "I agree with the Terms of Service & Privacy Policy",
                        style: AppTextStyles.subTitleTextStyle.copyWith(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomElevatdButton(buttonTXT: "Sign up", onTap: () {}),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an account?",
                        style: AppTextStyles.subTitleTextStyle.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Log in",
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