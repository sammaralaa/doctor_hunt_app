import 'package:flutter/material.dart';
import 'package:doctor_hunt_app/core/models/patient_model.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

class MenuItemData {
  final IconData icon;
  final String title;
  final int index;

  const MenuItemData({
    required this.icon,
    required this.title,
    required this.index,
  });
}

class MenuDrawerContent extends StatelessWidget {
  final PatientModel? patient;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onLogoutTap;
  final int selectedIndex;

  const MenuDrawerContent({
    super.key,
    required this.patient,
    required this.onItemSelected,
    required this.onLogoutTap,
    required this.selectedIndex,
  });

  String _getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return 'U';
    final trimmed = name.trim();
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      final first = parts[0].isNotEmpty ? parts[0][0].toUpperCase() : '';
      final second = parts[1].isNotEmpty ? parts[1][0].toUpperCase() : '';
      final initials = '$first$second';
      return initials.isNotEmpty ? initials : 'U';
    }
    return trimmed.length >= 2
        ? trimmed.substring(0, 2).toUpperCase()
        : trimmed.toUpperCase();
  }

  Widget _buildAvatar(BuildContext context) {
    final imageUrl = patient?.profileImage;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildInitialsFallback(context),
      );
    }
    return _buildInitialsFallback(context);
  }

  Widget _buildInitialsFallback(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      color: AppColors.white.withValues(alpha: 0.25),
      alignment: Alignment.center,
      child: Text(
        _getInitials(patient?.name),
        style: context.bold18White,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      MenuItemData(
        icon: Icons.person_outline_rounded,
        title: t.home,
        index: 0,
      ),
      MenuItemData(
        icon: Icons.favorite_outline_rounded,
        title: t.favourites,
        index: 1,
      ),
      MenuItemData(
        icon: Icons.calendar_month_outlined,
        title: t.myAppointments,
        index: 2,
      ),
      MenuItemData(
        icon: Icons.settings_outlined,
        title: t.settings,
        index: 3,
      ),
    ];

    final displayName = (patient != null && patient!.name.trim().isNotEmpty)
        ? patient!.name
        : 'Abdullah Mamun';

    final phoneNumber = (patient != null &&
            patient!.phoneNumber != null &&
            patient!.phoneNumber!.trim().isNotEmpty)
        ? patient!.phoneNumber!
        : '01303-527300';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Header
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.white,
                      width: 2.0,
                    ),
                  ),
                  child: ClipOval(
                    child: _buildAvatar(context),
                  ),
                ),
                const WidthSpace(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        displayName,
                        style: context.bold16White,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const HeightSpace(4),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 13,
                            color: AppColors.white.withValues(alpha: 0.85),
                          ),
                          const WidthSpace(6),
                          Expanded(
                            child: Text(
                              phoneNumber,
                              style: context.regular12White,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const HeightSpace(50),
            // Menu Items List
            Expanded(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: menuItems.length,
                separatorBuilder: (context, index) => const HeightSpace(8),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Material(
                    color: AppColors.transparent,
                    child: InkWell(
                      onTap: () => onItemSelected(item.index),
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 14,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              size: 24,
                              color: AppColors.white,
                            ),
                            const WidthSpace(20),
                            Expanded(
                              child: Text(
                                item.title,
                                style: context.bold16White,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              size: 22,
                              color: AppColors.white.withValues(alpha: 0.8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Logout Button at bottom left
            Material(
              color: AppColors.transparent,
              child: InkWell(
                onTap: onLogoutTap,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.logout_rounded,
                        size: 24,
                        color: AppColors.white,
                      ),
                      const WidthSpace(14),
                      Text(
                        t.logout,
                        style: context.bold16White,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
