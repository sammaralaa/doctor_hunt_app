import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/image_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FavoriteCardWidget extends StatefulWidget {
  final String imagePath;
  final String doctorName;
  final String specialty;
  final bool initialIsFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  const FavoriteCardWidget({
    super.key,
    required this.imagePath,
    required this.doctorName,
    required this.specialty,
    required this.initialIsFavorite,
    this.onTap,
    this.onFavoriteTap,
  });
  @override
  State<StatefulWidget> createState() => _FavoriteCardWidget();
}

class _FavoriteCardWidget extends State<FavoriteCardWidget> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialIsFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 180,
        //height: 180,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Align(
                alignment: AlignmentGeometry.topEnd,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? AppColors.red
                        : AppColors.inactiveIconColor,
                  ),
                ),
              ),
              Container(
                height: 84,
                width: 84,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: ClipOval(
                  child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                ),
              ),
              HeightSpace(11),
              Text(
                widget.doctorName,
                style: context.regular16TextMain,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                widget.specialty,
                style: context.regular12Primary,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
