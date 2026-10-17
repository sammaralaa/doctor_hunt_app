import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/presentation/controller/admin_doc_details_bloc.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/presentation/screens/admin_doctor_details_screen.dart';
import 'package:doctor_hunt_app/features/admin/admin_main_screen/presentation/screens/admin_main_screen.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/presentation/controller/create_doctor_bloc.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/presentation/screens/create-doctor-screen.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/controller/doctor_availability_bloc.dart';
import 'package:doctor_hunt_app/features/admin/doctor_availability/presentation/screens/doctor_availability_screen.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/presentation/controller/edit_doctor_bloc.dart';
import 'package:doctor_hunt_app/features/admin/edit_doctor/presentation/screens/edit_doctor_screen.dart';
import 'package:doctor_hunt_app/features/admin/edit_admin_profile/presentation/screens/edit_admin_profile_screen.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/screens/sign_up_screen.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/screens/login_screen.dart';
import 'package:doctor_hunt_app/features/common/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt_app/features/patient/doctor_details/presentation/controller/doctor_details_bloc.dart';
import 'package:doctor_hunt_app/features/patient/doctor_details/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/screens/doctors_list_screen.dart';
import 'package:doctor_hunt_app/features/patient/main_screen/presentation/screens/main_screen.dart';
import 'package:doctor_hunt_app/features/patient/home/presentation/screens/home_screen.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/screens/favorite_screen.dart';
import 'package:doctor_hunt_app/features/patient/patient_appointments/presentation/screens/patient_appointments_screen.dart';
import 'package:doctor_hunt_app/features/patient/patient_settings/presentation/screens/patient_settings_screen.dart';
import 'package:doctor_hunt_app/features/patient/search_doctors/presentation/controller/search_doctors_bloc.dart';
import 'package:doctor_hunt_app/features/patient/search_doctors/presentation/screens/search_screen.dart';
import 'package:doctor_hunt_app/features/common/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:doctor_hunt_app/features/patient/find_doctors/presentation/screens/find_doctors_screen.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_bloc.dart';
import 'package:doctor_hunt_app/features/patient/favorite/presentation/controller/favorites_event.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_bloc.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/controller/popular_doctors_event.dart';
import 'package:doctor_hunt_app/features/patient/popular_doctors/presentation/screens/popular_doctors_screen.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/controller/select_time_date_bloc.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/screens/select_time_date_screen.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/controller/appointment_details_bloc.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/controller/appointment_details_event.dart';
import 'package:doctor_hunt_app/features/common/appointment_details/presentation/screens/appointment_details_screen.dart';
import 'package:doctor_hunt_app/features/common/splash/presentation/screens/splash_screen.dart';
import 'package:doctor_hunt_app/features/patient/patient_profile/presentation/screens/patient_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData with $SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}

@TypedGoRoute<OnBoardingRoute>(path: '/on-boarding')
class OnBoardingRoute extends GoRouteData with $OnBoardingRoute {
  const OnBoardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OnboardingScreen();
  }
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  final String? userRole;
  const LoginRoute({this.userRole});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AuthBloc>(
      create: (context) => getIt<AuthBloc>(),
      child: LoginScreen(userRole: userRole),
    );
  }
}

@TypedGoRoute<SignUpRoute>(path: '/signup')
class SignUpRoute extends GoRouteData with $SignUpRoute {
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: SignUpScreen(),
    );
  }
}

@TypedStatefulShellRoute<MainShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<HomeBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<MainScreenRoute>(path: '/main'),
      ],
    ),
    TypedStatefulShellBranch<FavoriteBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<FavoriteRoute>(path: '/favorites'),
      ],
    ),
    TypedStatefulShellBranch<AppointmentsBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<PatientAppointmentsRoute>(path: '/appointments'),
      ],
    ),
    TypedStatefulShellBranch<SettingsBranchData>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<PatientSettingsRoute>(path: '/settings'),
      ],
    ),
  ],
)
class MainShellRouteData extends StatefulShellRouteData {
  const MainShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return MainScreen(navigationShell: navigationShell);
  }
}

class HomeBranchData extends StatefulShellBranchData {
  const HomeBranchData();
}

class FavoriteBranchData extends StatefulShellBranchData {
  const FavoriteBranchData();
}

class AppointmentsBranchData extends StatefulShellBranchData {
  const AppointmentsBranchData();
}

class SettingsBranchData extends StatefulShellBranchData {
  const SettingsBranchData();
}

class MainScreenRoute extends GoRouteData with $MainScreenRoute {
  const MainScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

class FavoriteRoute extends GoRouteData with $FavoriteRoute {
  const FavoriteRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FavoriteScreen();
  }
}

class PatientAppointmentsRoute extends GoRouteData
    with $PatientAppointmentsRoute {
  const PatientAppointmentsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PatientAppointmentsScreen();
  }
}

class PatientSettingsRoute extends GoRouteData with $PatientSettingsRoute {
  const PatientSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PatientSettingsScreen();
  }
}


@TypedGoRoute<ChooseRoleRoute>(path: '/choose-role')
class ChooseRoleRoute extends GoRouteData with $ChooseRoleRoute {
  const ChooseRoleRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChooseRoleScreen();
  }
}

@TypedGoRoute<DoctorDetailsRoute>(path: '/doctor-details')
class DoctorDetailsRoute extends GoRouteData with $DoctorDetailsRoute {
  final String doctorId;
  const DoctorDetailsRoute({required this.doctorId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<DoctorDetailsBloc>(),
      child: DoctorDetailsScreen(doctorId: doctorId,),
    );
  }
}

@TypedGoRoute<FindDoctorsRoute>(path: '/find-doctors')
class FindDoctorsRoute extends GoRouteData with $FindDoctorsRoute {
  const FindDoctorsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return FindDoctorsScreen();
  }
}

@TypedGoRoute<SelectTimeRoute>(path: '/select-time')
class SelectTimeRoute extends GoRouteData with $SelectTimeRoute {
  final String doctorId;
  const SelectTimeRoute({required this.doctorId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<SelectTimeDateBloc>(),
      child: SelectTimeDateScreen(doctorId: doctorId),
    );
  }
}

@TypedGoRoute<DoctorListRoute>(path: '/doctor-list')
class DoctorListRoute extends GoRouteData with $DoctorListRoute {
  const DoctorListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DoctorsListScreen();
  }
}

@TypedGoRoute<AdminMainRoute>(path: '/admin-main')
class AdminMainRoute extends GoRouteData with $AdminMainRoute {
  const AdminMainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AdminMainScreen();
  }
}

@TypedGoRoute<CreateDoctorRoute>(path: '/create-doctor')
class CreateDoctorRoute extends GoRouteData with $CreateDoctorRoute {
  const CreateDoctorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => getIt<CreateDoctorBloc>(),
      child: CreateDoctorScreen(),
    );
  }
}

@TypedGoRoute<AdminDoctorDetailsRoute>(path: '/admin-doctor-details')
class AdminDoctorDetailsRoute extends GoRouteData
    with $AdminDoctorDetailsRoute {
  final String doctorId;
  const AdminDoctorDetailsRoute({required this.doctorId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AdminDocDetailsBloc>(
      create: (context) => getIt<AdminDocDetailsBloc>(),
      child: AdminDoctorDetailsScreen(doctorId: doctorId),
    );
  }
}

@TypedGoRoute<EditDoctorRoute>(path: '/edit-doctor')
class EditDoctorRoute extends GoRouteData with $EditDoctorRoute {
  final String doctorId;
  const EditDoctorRoute({required this.doctorId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<EditDoctorBloc>(
      create: (context)=> getIt<EditDoctorBloc>(),
      child:  EditDoctorScreen(doctorId: doctorId),
    );
  }
}

@TypedGoRoute<DoctorAvailabilityRoute>(path: '/doctor-availability')
class DoctorAvailabilityRoute extends GoRouteData
    with $DoctorAvailabilityRoute {
  final String doctorId;
  const DoctorAvailabilityRoute({required this.doctorId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<DoctorAvailabilityBloc>(
      create: (context) => getIt<DoctorAvailabilityBloc>(),
      child: DoctorAvailabilityScreen(doctorId: doctorId),
    );
  }
}

@TypedGoRoute<PopularDoctorsRoute>(path: '/popular-doctors')
class PopularDoctorsRoute extends GoRouteData with $PopularDoctorsRoute {
  const PopularDoctorsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularDoctorsBloc>(
          create: (context) =>
              getIt<PopularDoctorsBloc>()..add(const FetchPopularDoctorsEvent()),
        ),
        BlocProvider<FavoritesBloc>.value(
          value: getIt<FavoritesBloc>()..add(const FetchFavoriteDoctorsEvent()),
        ),
      ],
      child: const PopularDoctorsScreen(),
    );
  }
}

@TypedGoRoute<AppointmentDetailsRoute>(path: '/appointment-details')
class AppointmentDetailsRoute extends GoRouteData
    with $AppointmentDetailsRoute {
  final String appointmentId;
  const AppointmentDetailsRoute({required this.appointmentId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AppointmentDetailsBloc>(
      create: (context) => getIt<AppointmentDetailsBloc>()
        ..add(FetchAppointmentDetailsEvent(appointmentId)),
      child: AppointmentDetailsScreen(appointmentId: appointmentId),
    );
  }
}

@TypedGoRoute<EditAdminProfileRoute>(path: '/edit-admin-profile')
class EditAdminProfileRoute extends GoRouteData with $EditAdminProfileRoute {
  const EditAdminProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EditAdminProfileScreen();
  }
}

@TypedGoRoute<PatientProfileRoute>(path: '/patient-profile')
class PatientProfileRoute extends GoRouteData with $PatientProfileRoute {
  const PatientProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PatientProfileScreen();
  }
}

@TypedGoRoute<SearchRoute>(path: '/search')
class SearchRoute extends GoRouteData with $SearchRoute {
  const SearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchDoctorsBloc>(
          create: (context) => getIt<SearchDoctorsBloc>(),
        ),
        BlocProvider<FavoritesBloc>.value(
          value: getIt<FavoritesBloc>()..add(const FetchFavoriteDoctorsEvent()),
        ),
      ],
      child: const SearchScreen(),
    );
  }
}

/**
@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  final String? userRole;
  const LoginRoute({this.userRole});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AuthBloc>(
      create: (context)=> getIt<AuthBloc>(),
      child:  LoginScreen(userRole: userRole),
      );
   
  }
} */
