import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/presentation/controller/edit_admin_profile_bloc.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/presentation/controller/edit_admin_profile_event.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/presentation/controller/edit_admin_profile_state.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/presentation/widgets/admin_profile_avatar_widget.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/presentation/widgets/admin_profile_text_field.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

class EditAdminProfileScreen extends StatelessWidget {
  const EditAdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<EditAdminProfileBloc>()
        ..add(const LoadAdminProfileEvent()),
      child: const EditAdminProfileView(),
    );
  }
}

class EditAdminProfileView extends StatefulWidget {
  const EditAdminProfileView({super.key});

  @override
  State<EditAdminProfileView> createState() => _EditAdminProfileViewState();
}

class _EditAdminProfileViewState extends State<EditAdminProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _clinicLocationController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _clinicLocationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );

    if (image != null && mounted) {
      context.read<EditAdminProfileBloc>().add(
            PickProfileImageEvent(File(image.path)),
          );
    }
  }

  void _onSave(EditAdminProfileLoadedState state) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<EditAdminProfileBloc>().add(
            UpdateAdminProfileEvent(
              name: _nameController.text.trim(),
              clinicLocation: _clinicLocationController.text.trim(),
              imageFile: state.pickedImage,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.titleColor,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          t.editProfile,
          style: context.bold18TextMain,
        ),
      ),
      body: BlocConsumer<EditAdminProfileBloc, EditAdminProfileState>(
        listener: (context, state) {
          if (state is EditAdminProfileLoadedState) {
            if (!_initialized) {
              _nameController.text = state.adminProfile.name;
              _emailController.text = state.adminProfile.email;
              _clinicLocationController.text =
                  state.adminProfile.clinicLocation;
              _initialized = true;
            }

            if (state.saveSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.profileUpdatedSuccessfully),
                  backgroundColor: AppColors.primaryColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: AppColors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is EditAdminProfileLoadingState ||
              state is EditAdminProfileInitialState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (state is EditAdminProfileErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: AppColors.red,
                    size: 40,
                  ),
                  const HeightSpace(12),
                  Text(
                    state.errorMessage,
                    style: context.regular14TextSub,
                    textAlign: TextAlign.center,
                  ),
                  const HeightSpace(12),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<EditAdminProfileBloc>().add(
                            const LoadAdminProfileEvent(),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: Text(
                      t.retry,
                      style: context.medium12White,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is EditAdminProfileLoadedState) {
            if (!_initialized) {
              _nameController.text = state.adminProfile.name;
              _emailController.text = state.adminProfile.email;
              _clinicLocationController.text =
                  state.adminProfile.clinicLocation;
              _initialized = true;
            }

            return SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 32,
                      ),
                      child: IntrinsicHeight(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const HeightSpace(10),
                              Center(
                                child: AdminProfileAvatarWidget(
                                  pickedImage: state.pickedImage,
                                  imageUrl: state.adminProfile.profileImage,
                                  name: _nameController.text.isNotEmpty
                                      ? _nameController.text
                                      : state.adminProfile.name,
                                  onTap: _pickImage,
                                ),
                              ),
                              const HeightSpace(32),

                              // FULL NAME
                              AdminProfileTextField(
                                label: t.fullNameUpper,
                                controller: _nameController,
                                prefixIcon: const Icon(
                                  Icons.person_outline_rounded,
                                  color: AppColors.inactiveIconColor,
                                  size: 20,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return t.pleaseEnterFullName;
                                  }
                                  return null;
                                },
                              ),
                              const HeightSpace(20),

                              // EMAIL ADDRESS (Read-only)
                              AdminProfileTextField(
                                label: t.emailAddressUpper,
                                controller: _emailController,
                                readOnly: true,
                                prefixIcon: const Icon(
                                  Icons.mail_outline_rounded,
                                  color: AppColors.inactiveIconColor,
                                  size: 20,
                                ),
                              ),
                              const HeightSpace(20),

                              // CLINIC LOCATION
                              AdminProfileTextField(
                                label: t.clinicLocationUpper,
                                controller: _clinicLocationController,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return t.pleaseEnterClinicLocation;
                                  }
                                  return null;
                                },
                              ),

                              const Spacer(),
                              const HeightSpace(32),

                              // Save Changes Button
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: state.isSaving
                                      ? null
                                      : () => _onSave(state),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: AppColors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: state.isSaving
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.5,
                                            color: AppColors.white,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.check,
                                              color: AppColors.white,
                                              size: 20,
                                            ),
                                            const WidthSpace(8),
                                            Text(
                                              t.saveChanges,
                                              style: context.bold16White,
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                              const HeightSpace(16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
