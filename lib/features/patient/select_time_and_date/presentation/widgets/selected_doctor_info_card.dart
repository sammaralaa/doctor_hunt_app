import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class SelectedDoctorInfoCard extends StatefulWidget {
  final VoidCallback? onBookNowPressed;
  final String name;
  final String location;
  final int rating;

  const SelectedDoctorInfoCard({
    super.key,
    this.onBookNowPressed,
    required this.name,
    required this.location, required this.rating,
  });

  @override
  State<StatefulWidget> createState() => _SelectedDoctorInfoCard();
}

class _SelectedDoctorInfoCard extends State<SelectedDoctorInfoCard> {
  bool isFavorite = true;
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  ImageAssets.doctorImage2,
                  width: 84,
                  height: 84,
                  fit: BoxFit.cover,
                ),
              ),
              WidthSpace(12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.name,
                            style: context.bold16TextMain,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: isFavorite
                                ? AppColors.red
                                : AppColors.inactiveIconColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    HeightSpace(4),

                    Text(widget.location, style: context.regular12TextSub),
                    HeightSpace(8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star_rounded,
                              color: index < widget.rating
                                  ? AppColors.yellow
                                  : AppColors.inactiveBorderColor,
                              size: 14,
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
