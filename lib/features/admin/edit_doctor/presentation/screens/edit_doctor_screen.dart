import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/utils/doctor_specialty_enum.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/widgets/custom_textfeild_widget.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class EditDoctorScreen extends StatefulWidget {
  final String doctorId;
  const EditDoctorScreen({super.key, required this.doctorId});

  @override
  State<EditDoctorScreen> createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  DoctorSpecialty? _selectedSpecialty;

  @override
  void initState() {
    super.initState();
    
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeightSpace(10),

              Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://res.cloudinary.com/ug4exgmz/image/upload/v1790100842/beph1q9wh4eriib9gekx.jpg",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                        width: 112,
                        height: 112,
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
                  Text(t.tapPhotoToChange, style: context.bold12Primary),
                ],
              ),
              HeightSpace(25),
              Text(
                t.doctorName,
                style: context.bold14TextMain,
                textAlign: TextAlign.start,
              ),
              CustomTextfeildWidget(
                width: double.infinity,
                preffixIcon: Icon(
                  Icons.person_outline,
                  color: AppColors.inactiveIconColor,
                ),
                initValue: "Dr. Sammar Alaa",
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
                  border: Border.all(color: AppColors.inactiveBorderColor),
                ),
                child: DropdownButton<DoctorSpecialty>(
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
                  border: BoxBorder.all(color: AppColors.inactiveBorderColor),
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                      child: Icon(
                        Icons.schedule,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Column(
                      children: [
                        Text(t.doctorStatus, style: context.regular14TextMain),
                        Text(
                          "Active & Available",
                          style: context.regular12TextSub,
                        ),
                      ],
                    ),
                    Spacer(),
                    Switch(
                      value: true,
                      activeThumbColor: AppColors.white,
                      activeTrackColor: AppColors.primaryColor,
                      inactiveThumbColor: AppColors.white,
                      inactiveTrackColor: AppColors.inactiveBorderColor,
                      onChanged: (value) {
                        // context.read<AdminDocDetailsBloc>().add(
                        //   ChangeDoctorStatusEvent(doctorId: doctorId, isActive: status),
                        // );
                      },
                    ),
                  ],
                ),
              ),
              const HeightSpace(50),

              CustomElevatdButton(
                buttonTXT: t.saveChanges,
                onTap: () {},
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
                            onPressed: () => Navigator.pop(dialogContext),
                            child: Text(t.cancel),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigator.pop(context);
                            },
                            child: Text(t.delete, style: context.bold12Warning),
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
                  label: Text(t.deleteDoctor, style: context.bold14Warning),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
