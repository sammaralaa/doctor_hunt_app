import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomElevatdButton extends StatelessWidget {
  final String buttonTXT;
  final VoidCallback? onTap;
  final double? buttonWidth;

  const CustomElevatdButton({super.key, required this.buttonTXT, this.onTap,this.buttonWidth});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width:  buttonWidth ??  295,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),
        child: Text(buttonTXT, style: context.bold18White),
      ),
    );
  }
}
