import 'package:flutter/cupertino.dart';


class WidthSpace extends StatelessWidget {
  final double width;
  const WidthSpace(this.width,{super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,);
  }
}

class HeightSpace extends StatelessWidget {
  final double height;
  const HeightSpace(this.height,{super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,);
  }
}