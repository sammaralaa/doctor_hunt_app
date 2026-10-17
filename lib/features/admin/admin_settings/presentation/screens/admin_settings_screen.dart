import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/admin_settings/presentation/controller/admin_settings_bloc.dart';
import 'package:doctor_hunt_app/features/admin/admin_settings/presentation/controller/admin_settings_event.dart';
import 'package:doctor_hunt_app/features/admin/admin_settings/presentation/controller/admin_settings_state.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/admin_logout_button.dart';
import '../widgets/admin_profile_card.dart';
import '../widgets/admin_settings_header.dart';
import '../widgets/admin_settings_options_card.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminSettingsBloc>(
      create: (context) =>
          getIt<AdminSettingsBloc>()..add(const LoadAdminSettingsEvent()),
      child: const AdminSettingsView(),
    );
  }
}

class AdminSettingsView extends StatelessWidget {
  const AdminSettingsView({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
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
              context.read<AdminSettingsBloc>().add(const AdminLogoutEvent());
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

  void _onChangePassword(BuildContext context) {
    // TODO: Navigate to Change Password screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          t.comingSoon,
          style: context.regular14White,
        ),
        backgroundColor: AppColors.primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _navigateToEditProfile(BuildContext context) async {
    await const EditAdminProfileRoute().push(context);
    if (context.mounted) {
      context.read<AdminSettingsBloc>().add(const LoadAdminSettingsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminSettingsBloc, AdminSettingsState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          const ChooseRoleRoute().go(context);
        } else if (state is AdminLogoutErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
                style: context.regular14White,
              ),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      child: Scaffold(
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
                  onProfilePressed: () => _navigateToEditProfile(context),
                ),
                const HeightSpace(22),
                BlocBuilder<AdminSettingsBloc, AdminSettingsState>(
                  buildWhen: (previous, current) =>
                      current is AdminSettingsInitialState ||
                      current is AdminSettingsLoadingState ||
                      current is AdminSettingsLoadedState ||
                      current is AdminSettingsErrorState,
                  builder: (context, state) {
                    if (state is AdminSettingsLoadingState ||
                        state is AdminSettingsInitialState) {
                      return Container(
                        height: 92,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      );
                    }

                    if (state is AdminSettingsErrorState) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColors.red,
                              size: 32,
                            ),
                            const WidthSpace(12),
                            Expanded(
                              child: Text(
                                state.errorMessage,
                                style: context.regular14TextSub,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.refresh,
                                color: AppColors.primaryColor,
                              ),
                              onPressed: () {
                                context
                                    .read<AdminSettingsBloc>()
                                    .add(const LoadAdminSettingsEvent());
                              },
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is AdminSettingsLoadedState) {
                      return AdminProfileCard(
                        name: state.adminProfile.name,
                        email: state.adminProfile.email,
                        imageUrl: state.adminProfile.profileImage,
                        onTap: () => _navigateToEditProfile(context),
                      );
                    }

                    return AdminProfileCard(
                      onTap: () => _navigateToEditProfile(context),
                    );
                  },
                ),
                const HeightSpace(20),
                AdminSettingsOptionsCard(
                  onAdminProfileTap: () => _navigateToEditProfile(context),
                  onChangePasswordTap: () => _onChangePassword(context),
                  onAppInformationTap: () {},
                  versionText: t.appVersionValue,
                ),
                const HeightSpace(28),
                BlocBuilder<AdminSettingsBloc, AdminSettingsState>(
                  builder: (context, state) {
                    final isLoggingOut = state is AdminLogoutLoadingState;
                    return isLoggingOut
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.red,
                            ),
                          )
                        : AdminLogoutButton(
                            onLogoutPressed: () => _showLogoutDialog(context),
                          );
                  },
                ),
                const HeightSpace(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
