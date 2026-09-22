import 'package:doctor_hunt_app/core/services/di.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/presentation/controller/admin_doc_details_bloc.dart';
import 'package:doctor_hunt_app/features/admin/admin_doctor_details/presentation/screens/admin_doctor_details_screen.dart';
import 'package:doctor_hunt_app/features/admin/admin_main_screen/presentation/screens/admin_main_screen.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/data/model/doctor_model.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/presentation/controller/Create_doctor_bloc.dart';
import 'package:doctor_hunt_app/features/admin/create-doctor/presentation/screens/create-doctor-screen.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/screens/sign_up_screen.dart';
import 'package:doctor_hunt_app/features/common/auth/presentation/screens/login_screen.dart';
import 'package:doctor_hunt_app/features/common/choose_role/presentation/screens/choose_role_screen.dart';
import 'package:doctor_hunt_app/features/patient/doctor_details/presentation/screens/doctor_details_screen.dart';
import 'package:doctor_hunt_app/features/admin/doctors_list/presentation/screens/doctors_list_screen.dart';
import 'package:doctor_hunt_app/features/patient/main_screen/presentation/screens/main_screen.dart';
import 'package:doctor_hunt_app/features/common/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:doctor_hunt_app/features/patient/find_doctors/presentation/screens/find_doctors_screen.dart';
import 'package:doctor_hunt_app/features/patient/select_time_and_date/presentation/screens/select_time_date_screen.dart';
import 'package:doctor_hunt_app/features/common/splash/presentation/screens/splash_screen.dart';
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

@TypedGoRoute<MainScreenRoute>(path: '/main')
class MainScreenRoute extends GoRouteData with $MainScreenRoute {
  const MainScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return MainScreen();
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
  const DoctorDetailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DoctorDetailsScreen();
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
  const SelectTimeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SelectTimeDateScreen();
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
class AdminDoctorDetailsRoute extends GoRouteData with $AdminDoctorDetailsRoute
     {
  final DoctorModel $extra;
  const AdminDoctorDetailsRoute({required this.$extra});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider<AdminDocDetailsBloc>(
      create: (context)=> getIt<AdminDocDetailsBloc>(),
      child: AdminDoctorDetailsScreen(doctor:  $extra,),
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
