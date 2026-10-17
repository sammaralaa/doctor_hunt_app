import 'package:flutter/material.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

/// Shows a confirmation dialog before cancelling an appointment.
Future<void> showCancelAppointmentDialog({
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
        t.cancelAppointment,
        style: dialogContext.bold18TextMain,
        textAlign: TextAlign.center,
      ),
      content: Text(
        t.areYouSureCancelAppointment,
        style: dialogContext.regular14TextSub,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(
            t.no,
            style: dialogContext.medium14TextSub,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            onConfirm();
          },
          child: Text(
            t.yesCancel,
            style: dialogContext.bold14Danger,
          ),
        ),
      ],
    ),
  );
}
