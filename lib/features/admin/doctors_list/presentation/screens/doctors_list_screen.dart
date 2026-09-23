import 'package:doctor_hunt_app/core/routing/routes.dart';
import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/custom_search_text_field_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/controller/doctors_list_bloc.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/controller/doctors_list_event.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/controller/doctors_list_state.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/widgets/admin_custom_app_bar.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/widgets/doctor_list_card.dart';
import 'package:doctor_hunt_app/generated/icons_assets.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DoctorsListScreen();
}

class _DoctorsListScreen extends State<DoctorsListScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'title': t.all, t.count: 12},
    {'title': t.cardiologist, t.count: 3},
    {'title': t.orthopedic, t.count: 2},
    {'title': t.dentist, t.count: 4},
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DoctorsListBloc>()..add(GetAllDoctorsEvent()),
      child: Scaffold(
        appBar: buildCustomAppBar(context),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              // Handle add doctor button press
              CreateDoctorRoute().push(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            backgroundColor: AppColors.primaryColor,

            icon: Icon(Icons.add, color: AppColors.white),
            label: Text(t.addDoctor, style: context.regular14White),
          ),
        ),

        body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<DoctorsListBloc, DoctorsListState>(
                  builder: (context, state) {
                    if (state is DoctorsListSuccessState) {
                      final doctors = state.doctors;

                      if (doctors.isNotEmpty) {
                        final activeDoctorsCount = doctors
                            .where((doctor) => doctor.isActive)
                            .length;
                        return Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: _doctorNumbers(
                                t.activeDoctors,
                                activeDoctorsCount.toString(),
                              ),
                            ),
                            WidthSpace(12),
                            Expanded(
                              child: _doctorNumbers(
                                t.totalDoctors,
                                doctors.length.toString(),
                              ),
                            ),
                          ],
                        );
                      }
                    }
                    return Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(child: _doctorNumbers(t.activeDoctors, "0")),
                        WidthSpace(12),
                        Expanded(child: _doctorNumbers(t.totalDoctors, "0")),
                      ],
                    );
                  },
                ),
                HeightSpace(16),

                CustomSearchTextFieldWidget(onSubmit: (value) {}),

                HeightSpace(14),

                HeightSpace(14),
                BlocConsumer<DoctorsListBloc, DoctorsListState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is DoctorsListLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DoctorsListSuccessState) {
                      final doctors = state.doctors;

                      if (doctors.isEmpty) {
                        return _emptyView();
                      }
                      return Column(
                        children: [
                          SizedBox(
                            height: 38,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _categories.length,
                              separatorBuilder: (_, _) => WidthSpace(8),
                              itemBuilder: (context, index) {
                                final isSelected = _selectedIndex == index;
                                final category = _categories[index];

                                return GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedIndex = index),
                                  child: AnimatedContainer(
                                    alignment: Alignment.center,
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primaryColor
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: isSelected
                                          ? null
                                          : Border.all(
                                              color:
                                                  AppColors.inactiveBorderColor,
                                            ),
                                    ),
                                    child: Text(
                                      '${category['title']} (${category['count']})',
                                      style: isSelected
                                          ? context.regular12White
                                          : context.regular12TextSub,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const HeightSpace(20),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return DoctorsListCard(
                                name: doctors[index].name,
                                specialization: doctors[index].specialty,
                                isActive: doctors[index].isActive,
                                imageUrl: doctors[index].profileImageUrl,
                                onCardPressed: () {
                                  //  book now
                                  AdminDoctorDetailsRoute(
                                    doctorId: doctors[index].id!,
                                  ).push(context);
                                },
                              );
                            },
                            separatorBuilder: (_, _) => HeightSpace(12),
                            itemCount: doctors.length,
                          ),
                        ],
                      );
                    } else if (state is DoctorsListFailureState) {
                      return Center(child: Text(state.errorMessage));
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _doctorNumbers(String title, String number) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(title, style: context.regular14TextSub),
          HeightSpace(4),
          Text(number, style: context.bold14Primary),
        ],
      ),
    );
  }

  Widget _emptyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HeightSpace(100),
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: BoxBorder.all(color: AppColors.primaryColorLight),
              ),
              child: SvgPicture.asset(IconsAssets.medicalIcon),
            ),
            Positioned(
              bottom: 1.0,
              right: 2.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child: Icon(Icons.add_rounded, color: AppColors.white),
              ),
            ),
          ],
        ),
        const HeightSpace(20),
        Text(t.noDoctorsFound, style: context.bold16TextMain),
        const HeightSpace(12),
        Text(
          t.thereAreCurrentlyNoDoctors,
          style: context.regular12TextSub,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
