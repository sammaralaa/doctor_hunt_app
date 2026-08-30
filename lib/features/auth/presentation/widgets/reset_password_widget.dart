import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/app_text_styles.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/auth/presentation/widgets/custom_textfeild_widget.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordWidget extends StatelessWidget{
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
          Text(
            'Reset Password',
            style: context.bold26TextMain,
            textAlign: TextAlign.start,
          ),

          HeightSpace(12),
          Text(
            'Set the new password for your account so you can login and access all the features.',
            style: context.regular14TextSub,
          ),

          SizedBox(height: 36.h),
          CustomTextfeildWidget(hintText: "New Password",),
          HeightSpace(18),
          CustomTextfeildWidget(hintText: "Re-enter Password",),
          HeightSpace(30),
          CustomElevatdButton(buttonTXT: "Update Password",onTap: (){},),
          HeightSpace(50),
        ],
      ),
    );
  }
}