import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import '../widgets/admin_logout_button.dart';
import '../widgets/admin_profile_card.dart';
import '../widgets/admin_settings_header.dart';
import '../widgets/admin_settings_options_card.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mintBackground.withValues(alpha: 0.35),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminSettingsHeader(
                onNotificationPressed: () {},
                onProfilePressed: () {},
              ),
              const HeightSpace(22),
              AdminProfileCard(
                onTap: () {},
              ),
              const HeightSpace(20),
              AdminSettingsOptionsCard(
                onAdminProfileTap: () {},
                onChangePasswordTap: () {},
                onAppInformationTap: () {},
              ),
              const HeightSpace(28),
              AdminLogoutButton(
                onLogoutPressed: () {},
              ),
              const HeightSpace(24),
            ],
          ),
        ),
      ),
    );
  }
}
