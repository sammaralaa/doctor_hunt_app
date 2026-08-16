import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopLeftColorShape extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -20, // Half of height (216 / 2) to center on corner
      left: -104, // Half of width (216 / 2)
      child: Container(
        width: 342.w,
        height: 342.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft, // Starting point of gradient
            end: Alignment.bottomRight, // Ending point of gradient
            colors: [Color(0xFF0EBE7E), Color(0xFF07D9AD)],
          ),
        ),
      ),
    );
  }

}