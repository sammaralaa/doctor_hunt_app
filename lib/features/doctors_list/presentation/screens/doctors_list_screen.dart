import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/custom_search_text_field_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/features/doctors_list/presentation/widgets/admin_custom_app_bar.dart';
import 'package:doctor_hunt_app/features/doctors_list/presentation/widgets/doctor_list_card.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';
import 'package:flutter/material.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DoctorsListScreen();
}

class _DoctorsListScreen extends State<DoctorsListScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'title': 'All', 'count': 12},
    {'title': 'Cardiologist', 'count': 3},
    {'title': 'Orthopedic', 'count': 2},
    {'title': 'Dentist', 'count': 4},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            // Handle add doctor button press
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
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: _doctorNumbers("Active Doctors", "1200")),
                  WidthSpace(12),
                  Expanded(child: _doctorNumbers("Total Doctors", "2500")),
                ],
              ),
              HeightSpace(16),

              CustomSearchTextFieldWidget(onSubmit: (value) {}),

              HeightSpace(14),
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
                      onTap: () => setState(() => _selectedIndex = index),
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
                                  color: AppColors.inactiveBorderColor,
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
              HeightSpace(14),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  bool isActive = index % 2 == 0;
                  return DoctorsListCard(
                    name: "Dr. John Doe",
                    specialization: "Cardiologist",
                    isActive: isActive,
                    onBookNowPressed: () {
                      //  book now
                    },
                  );
                },
                separatorBuilder: (_, _) => HeightSpace(12),
                itemCount: 6,
              ),
            ],
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
}
