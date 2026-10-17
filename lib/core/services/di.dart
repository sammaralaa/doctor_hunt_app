import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/data/repos/admin_doc_details_repository.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/presentation/controller/admin_doc_details_bloc.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/repos/create_doctor_repository.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/presentation/controller/create_doctor_bloc.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/data/repos/doctors_list_repository.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/controller/doctors_list_bloc.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/data/repos/doctor_availability_repository.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/controller/doctor_availability_bloc.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/data/repos/edit_doctor_repository.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/presentation/controller/edit_doctor_bloc.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/data/repos/admin_appointments_repository.dart';
import 'package:doctor_hunt_app/features/admin/admin_appointments/presentation/controller/admin_appointments_bloc.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/data/repos/edit_admin_profile_repository.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/presentation/controller/edit_admin_profile_bloc.dart';
import 'package:doctor_hunt_app/features/admin/admin_settings/data/repos/admin_settings_repository.dart';
import 'package:doctor_hunt_app/features/admin/admin_settings/presentation/controller/admin_settings_bloc.dart';
import 'package:doctor_hunt_app/features/common/auth/data/repos/auth_repository.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt_app/features/patient/doctor_details/data/repos/doctor_details_repository.dart';
import 'package:doctor_hunt_app/features/patient/doctor_details/presentation/controller/doctor_details_bloc.dart';
import 'package:doctor_hunt_app/features/patient/home/data/repos/home_repository.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_bloc.dart';
import 'package:doctor_hunt_app/features/patient/favorite/data/repos/favorites_repository.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_bloc.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/data/repos/patient_appointments_repository.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/controller/patient_appointments_bloc.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/data/repos/popular_doctors_repository.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_bloc.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/data/repos/appointment_details_repository.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/controller/appointment_details_bloc.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/data/repos/select_time_date_repository.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/controller/select_time_date_bloc.dart';
import 'package:doctor_hunt_app/features/patient/patient_settings/data/repos/patient_settings_repository.dart';
import 'package:doctor_hunt_app/features/patient/patient_settings/presentation/controller/patient_settings_bloc.dart';
import 'package:doctor_hunt_app/features/patient/patient_profile/data/repos/patient_profile_repository.dart';
import 'package:doctor_hunt_app/features/patient/patient_profile/presentation/controller/patient_profile_bloc.dart';
import 'package:doctor_hunt_app/features/patient/menu_drawer/data/repos/menu_drawer_repository.dart';
import 'package:doctor_hunt_app/features/patient/menu_drawer/presentation/controller/menu_drawer_bloc.dart';
import 'package:doctor_hunt_app/features/patient/search_doctors/data/repos/search_doctors_repository.dart';
import 'package:doctor_hunt_app/features/patient/search_doctors/presentation/controller/search_doctors_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);

  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  getIt.registerLazySingleton<CloudinaryServices>(() => CloudinaryServices());

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      firebaseAuth: getIt<FirebaseAuth>(),
      googleSignIn: getIt<GoogleSignIn>(),
      firestore: getIt<FirebaseFirestore>(),
      cloudinaryService: getIt<CloudinaryServices>(),
    ),
  );

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepository(
      firebaseAuth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerLazySingleton<EditDoctorRepository>(
    () => EditDoctorRepository(
      firebaseFirestore: getIt<FirebaseFirestore>(),
      cloudinaryService: getIt<CloudinaryServices>(),
    ),
  );

  getIt.registerLazySingleton<CreateDoctorRepository>(
    () => CreateDoctorRepository(
      firebaseAuth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
      cloudinaryService: getIt<CloudinaryServices>(),
    ),
  );
  getIt.registerLazySingleton<DoctorsListRepository>(
    () => DoctorsListRepository(firestore: getIt<FirebaseFirestore>()),
  );
  getIt.registerLazySingleton<AdminDocDetailsRepository>(
    () => AdminDocDetailsRepository(
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerLazySingleton<DoctorAvailabilityRepository>(
    () => DoctorAvailabilityRepository(
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerLazySingleton<SelectTimeDateRepository>(
    () => SelectTimeDateRepository(
      firestore: getIt<FirebaseFirestore>(),
      firebaseAuth: getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<AuthRepository>()));
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt<HomeRepository>()));
  getIt.registerLazySingleton<DoctorDetailsRepository>(
    () => DoctorDetailsRepository(
      firestore: getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepository(
      firestore: getIt<FirebaseFirestore>(),
      firebaseAuth: getIt<FirebaseAuth>(),
    ),
  );

  getIt.registerLazySingleton<FavoritesBloc>(
    () => FavoritesBloc(getIt<FavoritesRepository>()),
  );

  getIt.registerFactory<CreateDoctorBloc>(
    () => CreateDoctorBloc(getIt<CreateDoctorRepository>()),
  );
  getIt.registerFactory<DoctorsListBloc>(
    () => DoctorsListBloc(getIt<DoctorsListRepository>()),
  );
  getIt.registerFactory<AdminDocDetailsBloc>(
    () => AdminDocDetailsBloc(getIt<AdminDocDetailsRepository>()),
  );

  getIt.registerFactory<EditDoctorBloc>(
    () => EditDoctorBloc(getIt<EditDoctorRepository>()),
  );
  getIt.registerFactory<DoctorDetailsBloc>(
    () => DoctorDetailsBloc(getIt<DoctorDetailsRepository>()),
  );
  getIt.registerFactory<DoctorAvailabilityBloc>(
    () => DoctorAvailabilityBloc(getIt<DoctorAvailabilityRepository>()),
  );
  getIt.registerFactory<SelectTimeDateBloc>(
    () => SelectTimeDateBloc(repository: getIt<SelectTimeDateRepository>()),
  );
  getIt.registerLazySingleton<PopularDoctorsRepository>(
    () => PopularDoctorsRepository(firestore: getIt<FirebaseFirestore>()),
  );
  getIt.registerFactory<PopularDoctorsBloc>(
    () => PopularDoctorsBloc(repository: getIt<PopularDoctorsRepository>()),
  );
  getIt.registerLazySingleton<PatientAppointmentsRepository>(
    () => PatientAppointmentsRepository(
      firestore: getIt<FirebaseFirestore>(),
      firebaseAuth: getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerFactory<PatientAppointmentsBloc>(
    () => PatientAppointmentsBloc(
      repository: getIt<PatientAppointmentsRepository>(),
    ),
  );
  getIt.registerLazySingleton<AppointmentDetailsRepository>(
    () => AppointmentDetailsRepository(
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerFactory<AppointmentDetailsBloc>(
    () => AppointmentDetailsBloc(
      repository: getIt<AppointmentDetailsRepository>(),
    ),
  );
  getIt.registerLazySingleton<AdminAppointmentsRepository>(
    () => AdminAppointmentsRepository(
      firestore: getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerFactory<AdminAppointmentsBloc>(
    () => AdminAppointmentsBloc(
      repository: getIt<AdminAppointmentsRepository>(),
    ),
  );
  getIt.registerLazySingleton<EditAdminProfileRepository>(
    () => EditAdminProfileRepository(
      firestore: getIt<FirebaseFirestore>(),
      firebaseAuth: getIt<FirebaseAuth>(),
      cloudinaryService: getIt<CloudinaryServices>(),
    ),
  );
  getIt.registerFactory<EditAdminProfileBloc>(
    () => EditAdminProfileBloc(
      repository: getIt<EditAdminProfileRepository>(),
    ),
  );
  getIt.registerLazySingleton<AdminSettingsRepository>(
    () => AdminSettingsRepository(
      firestore: getIt<FirebaseFirestore>(),
      firebaseAuth: getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerFactory<AdminSettingsBloc>(
    () => AdminSettingsBloc(getIt<AdminSettingsRepository>()),
  );
  getIt.registerLazySingleton<PatientSettingsRepository>(
    () => PatientSettingsRepository(
      firestore: getIt<FirebaseFirestore>(),
      firebaseAuth: getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerFactory<PatientSettingsBloc>(
    () => PatientSettingsBloc(getIt<PatientSettingsRepository>()),
  );
  getIt.registerLazySingleton<PatientProfileRepository>(
    () => PatientProfileRepository(
      firestore: getIt<FirebaseFirestore>(),
      firebaseAuth: getIt<FirebaseAuth>(),
      cloudinaryService: getIt<CloudinaryServices>(),
    ),
  );
  getIt.registerFactory<PatientProfileBloc>(
    () => PatientProfileBloc(repository: getIt<PatientProfileRepository>()),
  );
  getIt.registerLazySingleton<MenuDrawerRepository>(
    () => MenuDrawerRepository(
      firestore: getIt<FirebaseFirestore>(),
      firebaseAuth: getIt<FirebaseAuth>(),
    ),
  );
  getIt.registerFactory<MenuDrawerBloc>(
    () => MenuDrawerBloc(repository: getIt<MenuDrawerRepository>()),
  );
  getIt.registerLazySingleton<SearchDoctorsRepository>(
    () => SearchDoctorsRepository(firestore: getIt<FirebaseFirestore>()),
  );
  getIt.registerFactory<SearchDoctorsBloc>(
    () => SearchDoctorsBloc(repository: getIt<SearchDoctorsRepository>()),
  );
}

