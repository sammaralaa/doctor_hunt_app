import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:flutter/material.dart';

class CustomSearchTextFieldWidget extends StatefulWidget {
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const CustomSearchTextFieldWidget({
    super.key,
    this.onSubmit,
    this.onChanged,
    this.controller,
  });

  @override
  State<StatefulWidget> createState() => _CustomSearchTextFieldWidget();
}

class _CustomSearchTextFieldWidget extends State<CustomSearchTextFieldWidget> {
  late final TextEditingController _controller;
  bool _isInternalController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _controller = TextEditingController();
      _isInternalController = true;
    }
  }

  @override
  void dispose() {
    if (_isInternalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha:0.06),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmit,
        decoration: InputDecoration(
          hintText: 'Search.....',
          hintStyle: context.regular16TextSub,
          prefixIcon: const Icon(Icons.search, color: AppColors.subtitleColor),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close, color: AppColors.subtitleColor),
            onPressed: () {
              //searchController.clear();
            },
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
