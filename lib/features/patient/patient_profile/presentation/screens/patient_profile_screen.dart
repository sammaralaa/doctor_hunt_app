import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/patient/patient_profile/presentation/controller/patient_profile_bloc.dart';
import 'package:doctor_hunt_app/features/patient/patient_profile/presentation/controller/patient_profile_event.dart';
import 'package:doctor_hunt_app/features/patient/patient_profile/presentation/controller/patient_profile_state.dart';
import 'package:doctor_hunt_app/features/patient/patient_profile/presentation/widgets/patient_profile_field_card.dart';
import 'package:doctor_hunt_app/features/patient/patient_profile/presentation/widgets/patient_profile_header.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientProfileBloc>(
      create: (context) =>
          getIt<PatientProfileBloc>()..add(const LoadPatientProfileEvent()),
      child: const PatientProfileView(),
    );
  }
}

class PatientProfileView extends StatefulWidget {
  const PatientProfileView({super.key});

  @override
  State<PatientProfileView> createState() => _PatientProfileViewState();
}

class _PatientProfileViewState extends State<PatientProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final ImagePicker _picker = ImagePicker();
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
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
      context.read<PatientProfileBloc>().add(
        PickPatientProfileImageEvent(File(image.path)),
      );
    }
  }

  void _onContinue(BuildContext context, File? pickedImage) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<PatientProfileBloc>().add(
        UpdatePatientProfileEvent(
          name: _nameController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
          imageFile: pickedImage,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientProfileBloc, PatientProfileState>(
      listener: (context, state) {
        if (state is PatientProfileLoadedState && !_initialized) {
          _nameController.text = state.patient.name;
          _phoneController.text = state.patient.phoneNumber ?? '';
          _initialized = true;
        } else if (state is PatientProfileUpdateSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                t.profileUpdatedSuccessfully,
                style: context.regular14White,
              ),
              backgroundColor: AppColors.primaryColor,
              duration: const Duration(seconds: 2),
            ),
          );
          context.pop();
        } else if (state is PatientProfileErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage, style: context.regular14White),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is PatientProfileLoadingState ||
            state is PatientProfileInitialState) {
          return const Scaffold(
            backgroundColor: AppColors.white,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            ),
          );
        }

        final patient = (state is PatientProfileLoadedState)
            ? state.patient
            : (state is PatientProfileUpdatingState)
            ? state.patient
            : null;

        final pickedImage = (state is PatientProfileLoadedState)
            ? state.pickedImage
            : (state is PatientProfileUpdatingState)
            ? state.pickedImage
            : null;

        final isUpdating = state is PatientProfileUpdatingState;

        return Scaffold(
          backgroundColor: AppColors.white,
          body: Column(
            children: [
              PatientProfileHeader(
                name: patient?.name ?? '',
                imageUrl: patient?.profileImage,
                pickedImage: pickedImage,
                onPickImageTap: _pickImage,
                onBackTap: () => context.pop(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeightSpace(28),
                        Text(
                          t.personalInformation,
                          style: context.bold18TextMain,
                        ),
                        const HeightSpace(16),
                        PatientProfileFieldCard(
                          label: t.name,
                          controller: _nameController,
                          focusNode: _nameFocus,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return t.pleaseEnterFullName;
                            }
                            return null;
                          },
                        ),
                        const HeightSpace(16),
                        PatientProfileFieldCard(
                          label: t.contactNumber,
                          controller: _phoneController,
                          focusNode: _phoneFocus,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return t.pleaseEnterContactNumber;
                            }
                            return null;
                          },
                        ),
                        const HeightSpace(32),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: isUpdating
                          ? null
                          : () => _onContinue(context, pickedImage),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        disabledBackgroundColor: AppColors.primaryColor
                            .withValues(alpha: 0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: isUpdating
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(t.kContinue, style: context.bold18White),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
