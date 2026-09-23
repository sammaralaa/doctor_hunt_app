import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class DoctorsListCard extends StatefulWidget {
  final VoidCallback? onCardPressed;
  final String name;
  final String specialization;
  final bool isActive;
  final String imageUrl;

  const DoctorsListCard({
    super.key,
    this.onCardPressed,
    required this.name,
    required this.specialization,
    required this.isActive,
    required this.imageUrl,
  });

  @override
  State<StatefulWidget> createState() => _DoctorsListCard();
}

class _DoctorsListCard extends State<DoctorsListCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onCardPressed,
      child: Container(
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
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
                width: 60,
                height: 60,
              ),
              // Image.network(
              //   widget.imageUrl,
              //   width: 60,
              //   height: 60,
              //   fit: BoxFit.cover,
              //   errorBuilder: (context, error, stackTrace) => Image.asset(
              //     ImageAssets.onBoarding5,
              //     width: 60,
              //     height: 60,
              //     fit: BoxFit.cover,
              //   ),
              // ),
              //  Image.asset(
              //   ImageAssets.doctorImage2,
              //   width: 44,
              //   height: 44,
              //   fit: BoxFit.cover,
              // ),
            ),
            WidthSpace(12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: context.bold16TextMain),
                Text(widget.specialization, style: context.regular12TextSub),
                HeightSpace(6),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.isActive
                        ? AppColors.primaryColorLight.withValues(alpha: 0.2)
                        : AppColors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: widget.isActive
                            ? AppColors.primaryColor
                            : AppColors.red,
                        size: 10,
                      ),
                      WidthSpace(4),
                      Text(
                        widget.isActive ? t.active : t.inactive,
                        style: widget.isActive
                            ? context.regular12Primary
                            : context.regular12Warning,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
