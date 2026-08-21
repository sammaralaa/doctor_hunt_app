import 'dart:ui';

import 'package:flutter/cupertino.dart';

class BottomRightShadowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -108,
      right: -108,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: 121, // Figma Blur: 121
          sigmaY: 121,
        ),
        child: Container(
          width: 216,
          height: 216,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF0EBE7E).withAlpha(90), // #0EBE7E @ 30%
          ),
        ),
      ),
    );
  }
}
