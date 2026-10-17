import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/app_logout_button.dart';
import 'package:doctor_hunt_app/core/widgets/app_logout_dialog.dart';
import 'package:doctor_hunt_app/core/widgets/app_profile_card.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/patient/patient_settings/presentation/controller/patient_settings_bloc.dart';
import 'package:doctor_hunt_app/features/patient/patient_settings/presentation/controller/patient_settings_event.dart';
import 'package:doctor_hunt_app/features/patient/patient_settings/presentation/controller/patient_settings_state.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/account_settings_section.dart';
import '../widgets/more_options_section.dart';

class PatientSettingsScreen extends StatelessWidget {
  const PatientSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientSettingsBloc>(
      create: (context) =>
          getIt<PatientSettingsBloc>()..add(const LoadPatientSettingsEvent()),
      child: const PatientSettingsView(),
    );
  }
}

class PatientSettingsView extends StatefulWidget {
  const PatientSettingsView({super.key});

  @override
  State<PatientSettingsView> createState() => _PatientSettingsViewState();
}

class _PatientSettingsViewState extends State<PatientSettingsView> {
  bool _notificationsEnabled = true;

  void _showComingSoonSnackBar(BuildContext context) {
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

  void _onChangePassword(BuildContext context) {
    // TODO: Navigate to Change Password screen
    _showComingSoonSnackBar(context);
  }

  void _onPrivacyPolicy(BuildContext context) {
    // TODO: Navigate to Privacy Policy screen or URL
    _showComingSoonSnackBar(context);
  }

  void _onLanguages(BuildContext context) {
    // TODO: Navigate to Language Selection screen
    _showComingSoonSnackBar(context);
  }

  void _onProfileTap(BuildContext context) async {
    await const PatientProfileRoute().push(context);
    if (context.mounted) {
      context.read<PatientSettingsBloc>().add(const LoadPatientSettingsEvent());
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showLogoutConfirmationDialog(
      context: context,
      onConfirm: () {
        context.read<PatientSettingsBloc>().add(const PatientLogoutEvent());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PatientSettingsBloc, PatientSettingsState>(
      listener: (context, state) {
        if (state is PatientLogoutSuccessState) {
          const ChooseRoleRoute().go(context);
        } else if (state is PatientLogoutErrorState) {
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
                Text(
                  t.settings,
                  style: context.bold24TextMain,
                ),
                const HeightSpace(22),
                BlocBuilder<PatientSettingsBloc, PatientSettingsState>(
                  buildWhen: (previous, current) =>
                      current is PatientSettingsInitialState ||
                      current is PatientSettingsLoadingState ||
                      current is PatientSettingsLoadedState ||
                      current is PatientSettingsErrorState,
                  builder: (context, state) {
                    if (state is PatientSettingsLoadingState ||
                        state is PatientSettingsInitialState) {
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

                    if (state is PatientSettingsErrorState) {
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
                                    .read<PatientSettingsBloc>()
                                    .add(const LoadPatientSettingsEvent());
                              },
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is PatientSettingsLoadedState) {
                      return GestureDetector(
                        onTap: () => _onProfileTap(context),
                        child: AppProfileCard(
                          name: state.patientProfile.name,
                          email: state.patientProfile.email,
                          imageUrl: state.patientProfile.profileImage,
                          defaultName: t.patientUser,
                          defaultEmail: 'patient@doctorhunt.com',
                          onTap: () => _onProfileTap(context),
                        ),
                      );
                    }

                    return GestureDetector(
                      onTap: () => _onProfileTap(context),
                      child: AppProfileCard(
                        defaultName: t.patientUser,
                        defaultEmail: 'patient@doctorhunt.com',
                        onTap: () => _onProfileTap(context),
                      ),
                    );
                  },
                ),
                const HeightSpace(28),
                AccountSettingsSection(
                  onChangePasswordTap: () => _onChangePassword(context),
                  notificationsEnabled: _notificationsEnabled,
                  onNotificationsChanged: (val) {
                    setState(() {
                      _notificationsEnabled = val;
                    });
                  },
                  onPrivacyPolicyTap: () => _onPrivacyPolicy(context),
                ),
                const HeightSpace(28),
                MoreOptionsSection(
                  onLanguagesTap: () => _onLanguages(context),
                  onBuildVersionTap: () {},
                  languageText: t.english,
                  versionText: t.appVersionValue,
                ),
                const HeightSpace(36),
                BlocBuilder<PatientSettingsBloc, PatientSettingsState>(
                  builder: (context, state) {
                    final isLoggingOut = state is PatientLogoutLoadingState;
                    return isLoggingOut
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.red,
                            ),
                          )
                        : AppLogoutButton(
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
