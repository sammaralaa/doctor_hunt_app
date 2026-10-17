import 'package:flutter/material.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';

class AdminProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const AdminProfileTextField({
    super.key,
    required this.label,
    required this.controller,
    this.prefixIcon,
    this.readOnly = false,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.bold12Secondary,
        ),
        const HeightSpace(8),
        Container(
          decoration: BoxDecoration(
            color: readOnly
                ? AppColors.mintBackground.withValues(alpha: 0.35)
                : AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: readOnly
                  ? AppColors.inactiveBorderColor.withValues(alpha: 0.7)
                  : AppColors.inactiveBorderColor,
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            keyboardType: keyboardType,
            validator: validator,
            style: readOnly
                ? context.medium14TextSub
                : context.bold14TextMain,
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              prefixIcon: prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 16, right: 12),
                      child: prefixIcon,
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
