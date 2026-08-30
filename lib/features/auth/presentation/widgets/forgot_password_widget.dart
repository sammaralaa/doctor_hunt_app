import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/auth/presentation/widgets/custom_textfeild_widget.dart';
import 'package:doctor_hunt_app/features/auth/presentation/widgets/enter_digits_widget.dart';
import 'package:doctor_hunt_app/features/auth/presentation/widgets/reset_password_widget.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(
      left: 20.w,
      right: 20.w,
      top: 12.h,
      bottom: MediaQuery.of(context).viewInsets.bottom + 30.h,
    ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeightSpace(12),
          Center(
            child: Container(
              width: 130.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.subtitleColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          HeightSpace(30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot password',
                style: context.bold26TextMain,
                textAlign: TextAlign.start,
              ),

              HeightSpace(12),
              Text(
                'Enter your email for the verification process, we will send 4 digits code to your email.',
                style: context.regular14TextSub,
              )
            ],
          ),

          SizedBox(height: 36.h),
          CustomTextfeildWidget(hintText: "Email",),
          HeightSpace(30),
          CustomElevatdButton(buttonTXT: "Continue",onTap: (){
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30.r),
                ),
              ),
              builder: (context) =>  EnterDigitsWidget(),
            );
          },),
          HeightSpace(50),
        ],
      ),
    );
  }
}