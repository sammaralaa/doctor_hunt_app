import 'package:flutter/material.dart';
import 'package:doctor_hunt_app/core/theme/app_colors.dart';
import 'package:doctor_hunt_app/core/widgets/bottom_right_shadow_widget.dart';
import 'package:doctor_hunt_app/core/widgets/custom_app_bar_widget.dart';
import 'package:doctor_hunt_app/core/widgets/spacing_widgets.dart';
import 'package:doctor_hunt_app/core/widgets/top_left_shadow_widget.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/widgets/patient_appointment_card_widget.dart';
import 'package:doctor_hunt_app/generated/style_atoms.dart';
import 'package:doctor_hunt_app/i18n/strings.g.dart';

class PatientAppointmentsScreen extends StatefulWidget {
  const PatientAppointmentsScreen({super.key});

  @override
  State<PatientAppointmentsScreen> createState() =>
      _PatientAppointmentsScreenState();
}

class _PatientAppointmentsScreenState extends State<PatientAppointmentsScreen> {
  PatientAppointmentStatus _selectedFilter = PatientAppointmentStatus.upcoming;

  // Simple static string variables directly in the UI as requested
  static const String _upcomingDoc1Name = 'Dr. Ananya Shah';
  static const String _upcomingDoc1Specialty = 'Specialist Cardiologist';
  static const String _upcomingDoc1Date = '02 Oct 2026';
  static const String _upcomingDoc1Time = '10:30 AM';
  static const String _upcomingDoc1Fee = '\$28.00';
  static const String _upcomingDoc1Image =
      'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=300';

  static const String _upcomingDoc2Name = 'Dr. Shruti Kedia';
  static const String _upcomingDoc2Specialty = 'Specialist Dentist';
  static const String _upcomingDoc2Date = '08 Oct 2026';
  static const String _upcomingDoc2Time = '02:00 PM';
  static const String _upcomingDoc2Fee = '\$32.00';
  static const String _upcomingDoc2Image =
      'https://images.unsplash.com/photo-1594824813583-84a141b777a8?q=80&w=300';

  static const String _completedDoc1Name = 'Dr. Sarah Tranquilli';
  static const String _completedDoc1Specialty = 'Specialist Medicine';
  static const String _completedDoc1Date = '21 Sep 2026';
  static const String _completedDoc1Time = '09:00 AM';
  static const String _completedDoc1Fee = '\$30.00';
  static const String _completedDoc1Image =
      'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=300';

  static const String _completedDoc2Name = 'Dr. Michael Bonebr...';
  static const String _completedDoc2Specialty = 'Specialist Dentist';
  static const String _completedDoc2Date = '12 Sep 2026';
  static const String _completedDoc2Time = '04:30 PM';
  static const String _completedDoc2Fee = '\$24.00';
  static const String _completedDoc2Image =
      'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=300';

  static const String _cancelledDoc1Name = 'Dr. Luke Whitesell';
  static const String _cancelledDoc1Specialty = 'Specialist Cardiology';
  static const String _cancelledDoc1Date = '30 Aug 2026';
  static const String _cancelledDoc1Time = '11:00 AM';
  static const String _cancelledDoc1Fee = '\$35.00';
  static const String _cancelledDoc1Image =
      'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=300';

  static const String _cancelledDoc2Name = 'Dr. Emily Shoemaker';
  static const String _cancelledDoc2Specialty = 'Specialist Pathology';
  static const String _cancelledDoc2Date = '16 Aug 2026';
  static const String _cancelledDoc2Time = '03:30 PM';
  static const String _cancelledDoc2Fee = '\$26.00';
  static const String _cancelledDoc2Image =
      'https://images.unsplash.com/photo-1594824813583-84a141b777a8?q=80&w=300';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const TopLeftShadowWidget(),
          const BottomRightShadowWidget(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const HeightSpace(10),
                  CustomAppBarWidget(
                    showSearchIcon: false,
                    title: t.appointments,
                  ),
                  const HeightSpace(20),
                  _buildFilterTabs(),
                  const HeightSpace(20),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: _buildAppointmentCards(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Row(
      children: [
        _buildTab(
          status: PatientAppointmentStatus.upcoming,
          title: t.upcoming,
        ),
        const SizedBox(width: 8),
        _buildTab(
          status: PatientAppointmentStatus.completed,
          title: t.completed,
        ),
        const SizedBox(width: 8),
        _buildTab(
          status: PatientAppointmentStatus.cancelled,
          title: t.cancelled,
        ),
      ],
    );
  }

  Widget _buildTab({
    required PatientAppointmentStatus status,
    required String title,
  }) {
    final isSelected = _selectedFilter == status;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilter = status;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor
                : AppColors.mintBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: isSelected ? context.medium12White : context.medium12Primary,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAppointmentCards() {
    switch (_selectedFilter) {
      case PatientAppointmentStatus.upcoming:
        return const [
          PatientAppointmentCardWidget(
            doctorName: _upcomingDoc1Name,
            doctorSpecialty: _upcomingDoc1Specialty,
            doctorImage: _upcomingDoc1Image,
            date: _upcomingDoc1Date,
            time: _upcomingDoc1Time,
            fee: _upcomingDoc1Fee,
            status: PatientAppointmentStatus.upcoming,
          ),
          PatientAppointmentCardWidget(
            doctorName: _upcomingDoc2Name,
            doctorSpecialty: _upcomingDoc2Specialty,
            doctorImage: _upcomingDoc2Image,
            date: _upcomingDoc2Date,
            time: _upcomingDoc2Time,
            fee: _upcomingDoc2Fee,
            status: PatientAppointmentStatus.upcoming,
          ),
        ];

      case PatientAppointmentStatus.completed:
        return const [
          PatientAppointmentCardWidget(
            doctorName: _completedDoc1Name,
            doctorSpecialty: _completedDoc1Specialty,
            doctorImage: _completedDoc1Image,
            date: _completedDoc1Date,
            time: _completedDoc1Time,
            fee: _completedDoc1Fee,
            status: PatientAppointmentStatus.completed,
          ),
          PatientAppointmentCardWidget(
            doctorName: _completedDoc2Name,
            doctorSpecialty: _completedDoc2Specialty,
            doctorImage: _completedDoc2Image,
            date: _completedDoc2Date,
            time: _completedDoc2Time,
            fee: _completedDoc2Fee,
            status: PatientAppointmentStatus.completed,
          ),
        ];

      case PatientAppointmentStatus.cancelled:
        return const [
          PatientAppointmentCardWidget(
            doctorName: _cancelledDoc1Name,
            doctorSpecialty: _cancelledDoc1Specialty,
            doctorImage: _cancelledDoc1Image,
            date: _cancelledDoc1Date,
            time: _cancelledDoc1Time,
            fee: _cancelledDoc1Fee,
            status: PatientAppointmentStatus.cancelled,
          ),
          PatientAppointmentCardWidget(
            doctorName: _cancelledDoc2Name,
            doctorSpecialty: _cancelledDoc2Specialty,
            doctorImage: _cancelledDoc2Image,
            date: _cancelledDoc2Date,
            time: _cancelledDoc2Time,
            fee: _cancelledDoc2Fee,
            status: PatientAppointmentStatus.cancelled,
          ),
        ];
    }
  }
}
