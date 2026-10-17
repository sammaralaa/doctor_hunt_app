// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashRoute,
  $onBoardingRoute,
  $loginRoute,
  $signUpRoute,
  $mainShellRouteData,
  $chooseRoleRoute,
  $doctorDetailsRoute,
  $findDoctorsRoute,
  $selectTimeRoute,
  $doctorListRoute,
  $adminMainRoute,
  $createDoctorRoute,
  $adminDoctorDetailsRoute,
  $editDoctorRoute,
  $doctorAvailabilityRoute,
  $popularDoctorsRoute,
  $appointmentDetailsRoute,
  $editAdminProfileRoute,
  $patientProfileRoute,
  $searchRoute,
];

RouteBase get $splashRoute => GoRouteData.$route(
  path: '/',
  hasOverriddenOnExit: false,
  factory: $SplashRoute._fromState,
);

mixin $SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onBoardingRoute => GoRouteData.$route(
  path: '/on-boarding',
  hasOverriddenOnExit: false,
  factory: $OnBoardingRoute._fromState,
);

mixin $OnBoardingRoute on GoRouteData {
  static OnBoardingRoute _fromState(GoRouterState state) =>
      const OnBoardingRoute();

  @override
  String get location => GoRouteData.$location('/on-boarding');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
  path: '/login',
  hasOverriddenOnExit: false,
  factory: $LoginRoute._fromState,
);

mixin $LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) =>
      LoginRoute(userRole: state.uri.queryParameters['user-role']);

  LoginRoute get _self => this as LoginRoute;

  @override
  String get location => GoRouteData.$location(
    '/login',
    queryParams: {if (_self.userRole != null) 'user-role': _self.userRole},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $signUpRoute => GoRouteData.$route(
  path: '/signup',
  hasOverriddenOnExit: false,
  factory: $SignUpRoute._fromState,
);

mixin $SignUpRoute on GoRouteData {
  static SignUpRoute _fromState(GoRouterState state) => const SignUpRoute();

  @override
  String get location => GoRouteData.$location('/signup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $mainShellRouteData => StatefulShellRouteData.$route(
  factory: $MainShellRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/main',
          hasOverriddenOnExit: false,
          factory: $MainScreenRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/favorites',
          hasOverriddenOnExit: false,
          factory: $FavoriteRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/appointments',
          hasOverriddenOnExit: false,
          factory: $PatientAppointmentsRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/settings',
          hasOverriddenOnExit: false,
          factory: $PatientSettingsRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $MainShellRouteDataExtension on MainShellRouteData {
  static MainShellRouteData _fromState(GoRouterState state) =>
      const MainShellRouteData();
}

mixin $MainScreenRoute on GoRouteData {
  static MainScreenRoute _fromState(GoRouterState state) =>
      const MainScreenRoute();

  @override
  String get location => GoRouteData.$location('/main');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $FavoriteRoute on GoRouteData {
  static FavoriteRoute _fromState(GoRouterState state) => const FavoriteRoute();

  @override
  String get location => GoRouteData.$location('/favorites');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientAppointmentsRoute on GoRouteData {
  static PatientAppointmentsRoute _fromState(GoRouterState state) =>
      const PatientAppointmentsRoute();

  @override
  String get location => GoRouteData.$location('/appointments');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PatientSettingsRoute on GoRouteData {
  static PatientSettingsRoute _fromState(GoRouterState state) =>
      const PatientSettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $chooseRoleRoute => GoRouteData.$route(
  path: '/choose-role',
  hasOverriddenOnExit: false,
  factory: $ChooseRoleRoute._fromState,
);

mixin $ChooseRoleRoute on GoRouteData {
  static ChooseRoleRoute _fromState(GoRouterState state) =>
      const ChooseRoleRoute();

  @override
  String get location => GoRouteData.$location('/choose-role');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $doctorDetailsRoute => GoRouteData.$route(
  path: '/doctor-details',
  hasOverriddenOnExit: false,
  factory: $DoctorDetailsRoute._fromState,
);

mixin $DoctorDetailsRoute on GoRouteData {
  static DoctorDetailsRoute _fromState(GoRouterState state) =>
      DoctorDetailsRoute(doctorId: state.uri.queryParameters['doctor-id']!);

  DoctorDetailsRoute get _self => this as DoctorDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/doctor-details',
    queryParams: {'doctor-id': _self.doctorId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $findDoctorsRoute => GoRouteData.$route(
  path: '/find-doctors',
  hasOverriddenOnExit: false,
  factory: $FindDoctorsRoute._fromState,
);

mixin $FindDoctorsRoute on GoRouteData {
  static FindDoctorsRoute _fromState(GoRouterState state) =>
      const FindDoctorsRoute();

  @override
  String get location => GoRouteData.$location('/find-doctors');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $selectTimeRoute => GoRouteData.$route(
  path: '/select-time',
  hasOverriddenOnExit: false,
  factory: $SelectTimeRoute._fromState,
);

mixin $SelectTimeRoute on GoRouteData {
  static SelectTimeRoute _fromState(GoRouterState state) =>
      SelectTimeRoute(doctorId: state.uri.queryParameters['doctor-id']!);

  SelectTimeRoute get _self => this as SelectTimeRoute;

  @override
  String get location => GoRouteData.$location(
    '/select-time',
    queryParams: {'doctor-id': _self.doctorId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $doctorListRoute => GoRouteData.$route(
  path: '/doctor-list',
  hasOverriddenOnExit: false,
  factory: $DoctorListRoute._fromState,
);

mixin $DoctorListRoute on GoRouteData {
  static DoctorListRoute _fromState(GoRouterState state) =>
      const DoctorListRoute();

  @override
  String get location => GoRouteData.$location('/doctor-list');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminMainRoute => GoRouteData.$route(
  path: '/admin-main',
  hasOverriddenOnExit: false,
  factory: $AdminMainRoute._fromState,
);

mixin $AdminMainRoute on GoRouteData {
  static AdminMainRoute _fromState(GoRouterState state) =>
      const AdminMainRoute();

  @override
  String get location => GoRouteData.$location('/admin-main');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $createDoctorRoute => GoRouteData.$route(
  path: '/create-doctor',
  hasOverriddenOnExit: false,
  factory: $CreateDoctorRoute._fromState,
);

mixin $CreateDoctorRoute on GoRouteData {
  static CreateDoctorRoute _fromState(GoRouterState state) =>
      const CreateDoctorRoute();

  @override
  String get location => GoRouteData.$location('/create-doctor');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $adminDoctorDetailsRoute => GoRouteData.$route(
  path: '/admin-doctor-details',
  hasOverriddenOnExit: false,
  factory: $AdminDoctorDetailsRoute._fromState,
);

mixin $AdminDoctorDetailsRoute on GoRouteData {
  static AdminDoctorDetailsRoute _fromState(GoRouterState state) =>
      AdminDoctorDetailsRoute(
        doctorId: state.uri.queryParameters['doctor-id']!,
      );

  AdminDoctorDetailsRoute get _self => this as AdminDoctorDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/admin-doctor-details',
    queryParams: {'doctor-id': _self.doctorId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $editDoctorRoute => GoRouteData.$route(
  path: '/edit-doctor',
  hasOverriddenOnExit: false,
  factory: $EditDoctorRoute._fromState,
);

mixin $EditDoctorRoute on GoRouteData {
  static EditDoctorRoute _fromState(GoRouterState state) =>
      EditDoctorRoute(doctorId: state.uri.queryParameters['doctor-id']!);

  EditDoctorRoute get _self => this as EditDoctorRoute;

  @override
  String get location => GoRouteData.$location(
    '/edit-doctor',
    queryParams: {'doctor-id': _self.doctorId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $doctorAvailabilityRoute => GoRouteData.$route(
  path: '/doctor-availability',
  hasOverriddenOnExit: false,
  factory: $DoctorAvailabilityRoute._fromState,
);

mixin $DoctorAvailabilityRoute on GoRouteData {
  static DoctorAvailabilityRoute _fromState(GoRouterState state) =>
      DoctorAvailabilityRoute(
        doctorId: state.uri.queryParameters['doctor-id']!,
      );

  DoctorAvailabilityRoute get _self => this as DoctorAvailabilityRoute;

  @override
  String get location => GoRouteData.$location(
    '/doctor-availability',
    queryParams: {'doctor-id': _self.doctorId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $popularDoctorsRoute => GoRouteData.$route(
  path: '/popular-doctors',
  hasOverriddenOnExit: false,
  factory: $PopularDoctorsRoute._fromState,
);

mixin $PopularDoctorsRoute on GoRouteData {
  static PopularDoctorsRoute _fromState(GoRouterState state) =>
      const PopularDoctorsRoute();

  @override
  String get location => GoRouteData.$location('/popular-doctors');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $appointmentDetailsRoute => GoRouteData.$route(
  path: '/appointment-details',
  hasOverriddenOnExit: false,
  factory: $AppointmentDetailsRoute._fromState,
);

mixin $AppointmentDetailsRoute on GoRouteData {
  static AppointmentDetailsRoute _fromState(GoRouterState state) =>
      AppointmentDetailsRoute(
        appointmentId: state.uri.queryParameters['appointment-id']!,
      );

  AppointmentDetailsRoute get _self => this as AppointmentDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/appointment-details',
    queryParams: {'appointment-id': _self.appointmentId},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $editAdminProfileRoute => GoRouteData.$route(
  path: '/edit-admin-profile',
  hasOverriddenOnExit: false,
  factory: $EditAdminProfileRoute._fromState,
);

mixin $EditAdminProfileRoute on GoRouteData {
  static EditAdminProfileRoute _fromState(GoRouterState state) =>
      const EditAdminProfileRoute();

  @override
  String get location => GoRouteData.$location('/edit-admin-profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $patientProfileRoute => GoRouteData.$route(
  path: '/patient-profile',
  hasOverriddenOnExit: false,
  factory: $PatientProfileRoute._fromState,
);

mixin $PatientProfileRoute on GoRouteData {
  static PatientProfileRoute _fromState(GoRouterState state) =>
      const PatientProfileRoute();

  @override
  String get location => GoRouteData.$location('/patient-profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $searchRoute => GoRouteData.$route(
  path: '/search',
  hasOverriddenOnExit: false,
  factory: $SearchRoute._fromState,
);

mixin $SearchRoute on GoRouteData {
  static SearchRoute _fromState(GoRouterState state) => const SearchRoute();

  @override
  String get location => GoRouteData.$location('/search');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
