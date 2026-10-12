import 'package:flutter_bloc/flutter_bloc.dart';
import 'admin_appointments_event.dart';
import 'admin_appointments_state.dart';

class AdminAppointmentsBloc extends Bloc<AdminAppointmentsEvent, AdminAppointmentsState> {
  AdminAppointmentsBloc() : super(const AdminAppointmentsState()) {
    on<LoadAppointmentsEvent>(_onLoadAppointments);
    on<ChangeFilterEvent>(_onChangeFilter);
  }

  void _onLoadAppointments(LoadAppointmentsEvent event, Emitter<AdminAppointmentsState> emit) {
    // Dummy Data Based on the UI designs
    final allAppointments = [
      MockAppointment(
        id: '1',
        patientName: 'Maya Patel',
        patientImage: '', // Mock empty image
        doctorName: 'Dr. Ananya Shah',
        doctorSpecialty: 'Cardiologist',
        date: '02 Oct 2026',
        time: '10:30 AM',
        fee: '\$28.00',
        status: AppointmentFilter.upcoming,
      ),
      MockAppointment(
        id: '2',
        patientName: 'James Wilson',
        patientImage: '',
        doctorName: 'Dr. Shruti Kedia',
        doctorSpecialty: 'Dentist',
        date: '08 Oct 2026',
        time: '02:00 PM',
        fee: '\$32.00',
        status: AppointmentFilter.upcoming,
      ),
      MockAppointment(
        id: '3',
        patientName: 'Olivia Martin',
        patientImage: '',
        doctorName: 'Dr. Sarah Tranquilli',
        doctorSpecialty: 'Internal Medicine',
        date: '21 Sep 2026',
        time: '09:00 AM',
        fee: '\$30.00',
        status: AppointmentFilter.completed,
        rating: 4.8,
        reviewText: 'Very professional and kind.',
      ),
      MockAppointment(
        id: '4',
        patientName: 'Daniel Kim',
        patientImage: '',
        doctorName: 'Dr. Michael Bonebrake',
        doctorSpecialty: 'Dentist',
        date: '12 Sep 2026',
        time: '04:30 PM',
        fee: '\$24.00',
        status: AppointmentFilter.completed,
        rating: 5.0,
        reviewText: 'Clear and reassuring.',
      ),
      MockAppointment(
        id: '5',
        patientName: 'Sophia Clark',
        patientImage: '',
        doctorName: 'Dr. Luke Whitesell',
        doctorSpecialty: 'Cardiologist',
        date: '30 Aug 2026',
        time: '11:00 AM',
        fee: '\$35.00',
        status: AppointmentFilter.cancelled,
      ),
      MockAppointment(
        id: '6',
        patientName: 'Ethan Brooks',
        patientImage: '',
        doctorName: 'Dr. Emily Shoemaker',
        doctorSpecialty: 'Pathologist',
        date: '18 Aug 2026',
        time: '03:30 PM',
        fee: '\$26.00',
        status: AppointmentFilter.cancelled,
      ),
    ];

    final filtered = allAppointments.where((a) => a.status == state.selectedFilter).toList();
    emit(state.copyWith(appointments: filtered));
  }

  void _onChangeFilter(ChangeFilterEvent event, Emitter<AdminAppointmentsState> emit) {
    emit(state.copyWith(selectedFilter: event.filter));
    add(LoadAppointmentsEvent());
  }
}
