import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

Future<void> showLogoutConfirmationDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        t.logout,
        style: dialogContext.bold18TextMain,
        textAlign: TextAlign.center,
      ),
      content: Text(
        t.areYouSureLogout,
        style: dialogContext.regular14TextSub,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(
            t.cancel,
            style: dialogContext.medium14TextSub,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            onConfirm();
          },
          child: Text(
            t.yesLogout,
            style: dialogContext.bold14Danger,
          ),
        ),
      ],
    ),
  );
}
