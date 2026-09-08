import 'package:flutter/cupertino.dart';

class TopLeftColorShape extends StatelessWidget{
  const TopLeftColorShape({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -20,
      left: -104,
      child: Container(
        width: 342,
        height: 342,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0EBE7E), Color(0xFF07D9AD)],
          ),
        ),
      ),
    );
  }

}