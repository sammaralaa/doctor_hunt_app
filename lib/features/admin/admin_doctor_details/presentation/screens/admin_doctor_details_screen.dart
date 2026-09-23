import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/presentation/controller/admin_doc_details_bloc.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/presentation/controller/admin_doc_details_event.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/presentation/controller/admin_doc_details_state.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AdminDoctorDetailsScreen extends StatefulWidget {
  final String doctorId;
  const AdminDoctorDetailsScreen({super.key, required this.doctorId});

  @override
  State<AdminDoctorDetailsScreen> createState() =>
      _AdminDoctorDetailsScreenState();
}

class _AdminDoctorDetailsScreenState extends State<AdminDoctorDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminDocDetailsBloc>().add(
      FetchDoctorDetailsEvent(docotrId: widget.doctorId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.doctorDetails),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<AdminDocDetailsBloc, AdminDocDetailsState>(
          builder: (context, state) {
            if (state is DoctorDetailsLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DoctorDetailsFailureState) {
            } else if (state is FetchDoctorDetailsSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HeightSpace(10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      key: ValueKey(state.doctor.profileImageUrl),
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
                  const HeightSpace(16),
                  Text(state.doctor.name, style: context.bold24TextMain),
                  const HeightSpace(6),
                  Text(state.doctor.specialty, style: context.regular14TextSub),
                  const HeightSpace(12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: state.doctor.isActive
                          ? AppColors.primaryColor.withValues(alpha: 0.2)
                          : AppColors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          color: state.doctor.isActive
                              ? AppColors.primaryColor
                              : AppColors.red,
                          size: 10,
                        ),
                        const WidthSpace(6),
                        Text(
                          state.doctor.isActive ? t.active : t.inactive,
                          style: state.doctor.isActive
                              ? context.regular12Primary
                              : context.regular12Warning,
                        ),
                      ],
                    ),
                  ),
                  const HeightSpace(30),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(IconsAssets.medicalIcon),

                            const WidthSpace(15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.speciality,
                                  style: context.regular12TextSub,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  state.doctor.specialty,
                                  style: context.bold14TextMain,
                                ),
                              ],
                            ),
                          ],
                        ),

                        Divider(
                          height: 30,
                          color: AppColors.inactiveBorderColor,
                        ),
                        _doctorStatusSection(
                          doctorId: state.doctor.id!,
                          status: state.doctor.isActive,
                        ),
                      ],
                    ),
                  ),
                  const HeightSpace(30),

                  CustomElevatdButton(
                    buttonTXT: t.editDoctor,
                    onTap: () async {
                      await EditDoctorRoute(
                        doctorId: state.doctor.id!,
                      ).push(context);
                      if (context.mounted) {
                        context.read<AdminDocDetailsBloc>().add(
                          FetchDoctorDetailsEvent(docotrId: widget.doctorId),
                        );
                      }
                    },
                    buttonWidth: double.infinity,
                  ),
                  const HeightSpace(16),
                  TextButton.icon(
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
                                Navigator.pop(dialogContext);

                                context.read<AdminDocDetailsBloc>().add(
                                  DeleteDoctorEvent(doctorId: state.doctor.id!),
                                );
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
                    label: Text(t.deleteDoctor, style: context.bold14Warning),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _doctorStatusSection({
    required bool status,
    required String doctorId,
  }) {
    return Row(
      children: [
        const Icon(
          Icons.toggle_on_outlined,
          color: AppColors.primaryColor,
          size: 20,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.accountStatus, style: context.regular12TextSub),
            const HeightSpace(2),
            Text(status ? t.active : t.inactive, style: context.bold14TextMain),
          ],
        ),
        const Spacer(),

        Switch(
          value: status,
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
    );
  }
}
