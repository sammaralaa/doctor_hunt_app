import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class DoctorDetailsCardWidget extends StatefulWidget {
  final VoidCallback? onBookNowPressed;
  final String name;
  final String specialty;
  final String imageUrl;

  const DoctorDetailsCardWidget({
    super.key,
    this.onBookNowPressed,
    required this.name,
    required this.specialty, required this.imageUrl,
  });
  @override
  State<DoctorDetailsCardWidget> createState() =>
      _DoctorDetailsCardWidgetState();
}

class _DoctorDetailsCardWidgetState extends State<DoctorDetailsCardWidget> {
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
                child:CachedNetworkImage(
                imageUrl: widget.imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
                width: 85,
                height: 85,
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

                    Text(widget.specialty, style: context.regular12TextSub),
                    HeightSpace(8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star_rounded,
                              color: index < 4
                                  ? AppColors.yellow
                                  : AppColors.inactiveBorderColor,
                              size: 14,
                            );
                          }),
                        ),

                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\$ ',
                                style: context.bold16Primary,
                              ),
                              TextSpan(
                                text: '28.00/hr',
                                style: context.regular16TextSub,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          HeightSpace(12),

          SizedBox(
            width: 140,
            height: 34,
            child: ElevatedButton(
              onPressed: widget.onBookNowPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Text(t.bookNow, style: context.bold14White),
            ),
          ),
        ],
      ),
    );
  }
}
