import 'package:doctor_hunt_app/features/auth/presentation/widgets/reset_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import 'custom_textfeild_widget.dart';

class EnterDigitsWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _EnterDigitsWidget();
}
class _EnterDigitsWidget extends State<EnterDigitsWidget>{
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
                'Enter 4 Digits Code',
                style: AppTextStyles.titleTextStyle,
                textAlign: TextAlign.start,
              ),

              HeightSpace(12),
              Text(
                'Enter the 4 digits code that you received on your email.',
                style: AppTextStyles.subTitleTextStyle,
              ),
            ],
          ),


          HeightSpace(35),
          MaterialPinField(length: 4),
          HeightSpace(40),
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
              builder: (context) =>  ResetPasswordWidget(),
            );
          },),
          HeightSpace(50),
        ],
      ),
    );
  }

}