import 'dart:io';

import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/presentation/controller/Create_doctor_bloc.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/presentation/controller/Create_doctor_state.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/presentation/controller/create_doctor_event.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/widgets/custom_textfeild_widget.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateDoctorScreen extends StatefulWidget {
  const CreateDoctorScreen({super.key});

  @override
  State<CreateDoctorScreen> createState() => _CreateDoctorScreenState();
}

class _CreateDoctorScreenState extends State<CreateDoctorScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  String? _selectedSpecialty;
  XFile? _pickedFile;
  final List<String> _specialties = [
    'Cardiology',
    'Orthopedic',
    'Dentistry',
    'General Medicine',
  ];
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t.createDoctor)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightSpace(10),
              Center(
                child: Column(
                  children: [
                    DottedBorder(
                      options: CircularDottedBorderOptions(
                        dashPattern: [6, 4],
                        strokeWidth: 2,
                        padding: EdgeInsets.all(3),
                        color: AppColors.inactiveIconColor,
                      ),
                      // 6px dash, 4px gap
                      child: Container(
                        width: 95,
                        height: 95,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                          image: _pickedFile != null
                              ? DecorationImage(
                                  image: FileImage(File(_pickedFile!.path)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _pickedFile == null
                            ? Icon(
                                Icons.camera_alt_outlined,
                                size: 32,
                                color: AppColors.inactiveIconColor,
                              )
                            : null,
                      ),
                    ),
                    HeightSpace(10),
                    TextButton(
                      onPressed: () async {
                        ImageSource source = ImageSource.gallery;
                        final ImagePicker picker = ImagePicker();
                        final image = await picker.pickImage(
                          source: source,
                          maxWidth: 512,
                          maxHeight: 512,
                          imageQuality: 80,
                        );
                        setState(() {
                          _pickedFile = image;
                        });
                      },
                      child: Text(t.addPhoto, style: context.bold14Primary),
                    ),
                  ],
                ),
              ),

              HeightSpace(42),
              Text(
                t.doctorName,
                style: context.bold12TextMain,
                textAlign: TextAlign.start,
              ),
              HeightSpace(8),
              CustomTextfeildWidget(
                hintText: t.eGDrAhmedAli,
                controller: nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please, Enter doctor name';
                  }
                  return null;
                },
              ),
              HeightSpace(20),
              Text(t.medicalSpecialty, style: context.bold12TextMain),
              HeightSpace(8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.inactiveBorderColor),
                ),
                child: DropdownButton<String>(
                  value: _selectedSpecialty,
                  hint: Text(
                    t.selectSpecialty,
                    style: context.regular14TextPlaceholder,
                  ),
                  isExpanded: true, // Takes full available width
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.black,
                  ),
                  items: _specialties.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: context.regular14TextMain),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSpecialty = newValue;
                    });
                  },
                ),
              ),
              HeightSpace(40),
              BlocConsumer<CreateDoctorBloc, CreateDoctorState>(
                listener: (context, state) {
                  if (state is CreateDoctorSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                        content: Text(t.doctorAddedSuccessfully),
                      ),
                    );
                  } else if (state is CreateDoctorFailureState) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
                  }
                },
                builder: (context, state) {
                  final isLoading = state is CreateDoctorLoadingState;
                  return CustomElevatdButton(
                    childWidget: isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(t.createDoctor, style: context.bold18White),
                    buttonWidth: double.infinity,
                    onTap: isLoading
                        ? null
                        : () {
                            if (formKey.currentState!.validate()) {
                              if (_selectedSpecialty == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please, Choose Doctor Specialty",
                                    ),
                                  ),
                                );
                                return;
                              }

                              context.read<CreateDoctorBloc>().add(
                                CreateNewDoctorEvent(
                                  name: nameController.text.trim(),
                                  specialty:
                                      _selectedSpecialty ?? 'General Medicine',
                                  imageFile: File(_pickedFile!.path),
                                ),
                              );
                            }
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
