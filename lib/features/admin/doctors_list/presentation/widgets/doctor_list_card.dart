import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class DoctorsListCard extends StatefulWidget {
  final VoidCallback? onBookNowPressed;
  final String name;
  final String specialization;
  final bool isActive;

  const DoctorsListCard({
    super.key,
    this.onBookNowPressed,
    required this.name,
    required this.specialization,
    required this.isActive,
  });

  @override
  State<StatefulWidget> createState() => _DoctorsListCard();
}

class _DoctorsListCard extends State<DoctorsListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              ImageAssets.doctorImage2,
              width: 44,
              height: 44,
              fit: BoxFit.cover,
            ),
          ),
          WidthSpace(12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(widget.name, style: context.bold16TextMain),
                    WidthSpace(6),
                    Icon(
                      Icons.circle,
                      color: widget.isActive
                          ? AppColors.primaryColor
                          : AppColors.inactiveIconColor,
                      size: 10,
                    ),
                  ],
                ),
                Text(widget.specialization, style: context.regular12TextSub),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: widget.isActive
                  ? AppColors.primaryColorLight.withValues(alpha: 0.2)
                  : AppColors.inactiveBorderColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              widget.isActive ? "Active" : "Inactive",
              style: widget.isActive
                  ? context.regular12Primary
                  : context.regular12TextSub,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.more_vert,
              color: AppColors.inactiveIconColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
