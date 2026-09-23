import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/utils/doctor_specialty_enum.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/presentation/controller/edit_doctor_bloc.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/presentation/controller/edit_doctor_event.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/presentation/controller/edit_doctor_state.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/widgets/custom_textfeild_widget.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditDoctorScreen extends StatefulWidget {
  final String doctorId;
  const EditDoctorScreen({super.key, required this.doctorId});

  @override
  State<EditDoctorScreen> createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  DoctorSpecialty? _selectedSpecialty;
  late TextEditingController _controller;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    context.read<EditDoctorBloc>().add(
      FetchDoctorDetailsEvent(doctorId: widget.doctorId),
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.editDoctor),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.inactiveIconColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<EditDoctorBloc, EditDoctorState>(
            listener: (context, state) {
              if (state is FetchDoctorSuccessState) {
                _controller.text = state.doctor.name;
                _selectedSpecialty = DoctorSpecialty.fromKey(
                  state.doctor.specialty,
                );
              } else if (state is UpdateDoctorSuccessState) {
                if (context.mounted) Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is FetchDoctorLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UpdateDoctorSuccessState) {
                if (context.mounted) {
                  Navigator.pop(context, true);
                }
                
              } else if (state is FetchDoctorSuccessState) {
                final currentIsActive = state.isActive ?? state.doctor.isActive;
                final currentImagePath = state.newImagePath;
                return Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeightSpace(10),

                      Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? pickedFile = await picker
                                    .pickImage(source: ImageSource.gallery);

                                if (pickedFile != null && context.mounted) {
                                  // Dispatch event to update local state immediately
                                  context.read<EditDoctorBloc>().add(
                                    ChangeDoctorImageEvent(
                                      imagePath: pickedFile.path,
                                    ),
                                  );
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: currentImagePath != null
                                    ? Image.file(
                                        File(currentImagePath),
                                        width: 112,
                                        height: 112,
                                        fit: BoxFit.cover,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: state.doctor.profileImageUrl,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.cover,
                                        width: 112,
                                        height: 112,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              right: 1,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryColor,
                                  border: BoxBorder.all(
                                    color: AppColors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.photo_camera_outlined,
                                  color: AppColors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      HeightSpace(15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_camera_outlined,
                            color: AppColors.primaryColor,
                            size: 18,
                          ),
                          WidthSpace(6),
                          Text(
                            t.tapPhotoToChange,
                            style: context.bold12Primary,
                          ),
                        ],
                      ),
                      HeightSpace(25),
                      Text(
                        t.doctorName,
                        style: context.bold14TextMain,
                        textAlign: TextAlign.start,
                      ),
                      CustomTextfeildWidget(
                        controller: _controller,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please, Enter doctor name';
                          }
                          return null;
                        },
                        width: double.infinity,
                        preffixIcon: Icon(
                          Icons.person_outline,
                          color: AppColors.inactiveIconColor,
                        ),
                        // initValue: state.doctor.name,
                      ),
                      HeightSpace(16),
                      Text(
                        t.speciality,
                        style: context.bold14TextMain,
                        textAlign: TextAlign.start,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.inactiveBorderColor,
                          ),
                        ),
                        child: DropdownButton<DoctorSpecialty>(
                          value: _selectedSpecialty,
                          hint: Text(
                            t.selectSpecialty,
                            style: context.regular14TextPlaceholder,
                          ),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.black,
                          ),
                          items: DoctorSpecialty.values.map((
                            DoctorSpecialty specialty,
                          ) {
                            return DropdownMenuItem<DoctorSpecialty>(
                              value: specialty,
                              child: Text(
                                specialty.displayName,
                                style: context.regular14TextMain,
                              ),
                            );
                          }).toList(),
                          onChanged: (DoctorSpecialty? newValue) {
                            setState(() {
                              _selectedSpecialty = newValue;
                            });
                          },
                        ),
                      ),
                      HeightSpace(16),
                      Container(
                        padding: EdgeInsetsGeometry.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: BoxBorder.all(
                            color: AppColors.inactiveBorderColor,
                          ),
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadiusGeometry.circular(12),
                              ),
                              child: Icon(
                                Icons.schedule,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            WidthSpace(6),
                            Column(
                              children: [
                                Text(
                                  t.doctorStatus,
                                  style: context.regular14TextMain,
                                ),
                                Text(
                                  currentIsActive ? t.active : t.inactive,
                                  style: context.regular12TextSub,
                                ),
                              ],
                            ),
                            Spacer(),
                            Switch(
                              value: currentIsActive,
                              activeThumbColor: AppColors.white,
                              activeTrackColor: AppColors.primaryColor,
                              inactiveThumbColor: AppColors.white,
                              inactiveTrackColor: AppColors.inactiveBorderColor,
                              onChanged: (value) {
                                print(value);
                                context.read<EditDoctorBloc>().add(
                                  ToggleDoctorStatusEvent(isActive: value),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const HeightSpace(50),
                      CustomElevatdButton(
                        buttonTXT: t.saveChanges,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            if (currentImagePath != null) {
                              context.read<EditDoctorBloc>().add(
                                UpdateDoctorDetailsEvent(
                                  doctorId: state.doctor.id!,
                                  name: _controller.text.trim(),
                                  specialty: _selectedSpecialty!,
                                  isActive: currentIsActive,
                                  imageFile: currentImagePath,
                                ),
                              );
                            }
                            context.read<EditDoctorBloc>().add(
                              UpdateDoctorDetailsEvent(
                                doctorId: state.doctor.id!,
                                name: _controller.text.trim(),
                                specialty: _selectedSpecialty!,
                                isActive: currentIsActive,
                              ),
                            );
                          }
                        },
                        buttonWidth: double.infinity,
                      ),
                      const HeightSpace(16),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (dialogContext) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: Text(
                                  t.deleteDoctor,
                                  textAlign: TextAlign.center,
                                ),
                                content: Text(t.areYouSureYouWantDelete),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext),
                                    child: Text(t.cancel),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Navigator.pop(context);
                                    },
                                    child: Text(
                                      t.delete,
                                      style: context.bold12Warning,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.red,
                            size: 20,
                          ),
                          label: Text(
                            t.deleteDoctor,
                            style: context.bold14Warning,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
