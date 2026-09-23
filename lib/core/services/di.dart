import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/data/repos/admin_doc_details_repository.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/presentation/controller/admin_doc_details_bloc.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/repos/create_doctor_repository.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/presentation/controller/create_doctor_bloc.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/data/repos/doctors_list_repository.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/controller/doctors_list_bloc.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/data/repos/edit_doctor_repository.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/presentation/controller/edit_doctor_bloc.dart';
import 'package:doctor_hunt_app/features/common/auth/data/repos/auth_repository.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt_app/features/patient/home/data/repos/home_repository.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_bloc.dart';
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
  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<AuthRepository>()));
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt<HomeRepository>()));
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
}
