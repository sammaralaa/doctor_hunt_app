import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_hunt_app/core/services/cloudinary_services.dart';
import 'package:doctor_hunt_app/features/common/auth/data/repos/auth_repository.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt_app/features/patient/home/data/repos/home_repository.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/controller/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  /* final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CloudinaryServices _cloudinaryService = CloudinaryServices(); */
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
      cloudinaryService: getIt<CloudinaryServices>(),
    ),
  );

  getIt.registerFactory<AuthBloc>(() => AuthBloc(getIt<AuthRepository>()));
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt<HomeRepository>()));
}
