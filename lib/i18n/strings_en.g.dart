///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'LIVE'
	String get live => 'LIVE';

	/// en: 'Doctor Hunt'
	String get doctor_hunt => 'Doctor Hunt';

	/// en: 'Doctor Details'
	String get doctorDetails => 'Doctor Details';

	/// en: 'Find Your Doctor'
	String get findYourDoctor => 'Find Your Doctor';

	/// en: 'Search.....'
	String get search => 'Search.....';

	/// en: 'Next Available'
	String get nextAvailable => 'Next Available';

	/// en: 'Book Now'
	String get bookNow => 'Book Now';

	/// en: 'Popular Doctors'
	String get popularDoctors => 'Popular Doctors';

	/// en: 'See all'
	String get seeAll => 'See all';

	/// en: 'Feature Doctor'
	String get featureDoctor => 'Feature Doctor';

	/// en: 'Live Doctors'
	String get liveDoctors => 'Live Doctors';

	/// en: 'Select Time'
	String get selectTime => 'Select Time';

	/// en: 'No slots available'
	String get noSlotsAvailable => 'No slots available';

	/// en: 'OR'
	String get or => 'OR';

	/// en: 'Contact Clinic'
	String get contactClinic => 'Contact Clinic';

	/// en: 'Evening $length slots'
	String eveningSlots({required Object length}) => 'Evening ${length} slots';

	/// en: 'Afternoon $length slots'
	String afternoonSlots({required Object length}) => 'Afternoon ${length} slots';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Name'
	String get name => 'Name';

	/// en: 'Facebook'
	String get facebook => 'Facebook';

	/// en: 'Google'
	String get google => 'Google';

	/// en: 'User'
	String get user => 'User';

	/// en: 'Have an account?'
	String get haveAnAccount => 'Have an account?';

	/// en: 'Log in'
	String get logIn => 'Log in';

	/// en: 'Sign up'
	String get signUp => 'Sign up';

	/// en: 'I agree with the Terms of Service & Privacy Policy'
	String get iAgreeWithTheTerms => 'I agree with the Terms of Service & Privacy Policy';

	/// en: 'Join us'
	String get joinUs => 'Join us';

	/// en: 'Hi $userName!'
	String hi({required Object userName}) => 'Hi ${userName}!';

	/// en: 'Welcome back'
	String get welcomeBack => 'Welcome back';

	/// en: 'Enter your Name'
	String get enterYourName => 'Enter your Name';

	/// en: 'Enter your email'
	String get enterYourEmail => 'Enter your email';

	/// en: 'Enter your Password'
	String get enterYourPassword => 'Enter your Password';

	/// en: 'password must be at least 8 characters'
	String get passwordMustBe => 'password must be at least 8 characters';

	/// en: 'Next availability on $nextAvailable'
	String nextAvailabilityOn({required Object nextAvailable}) => 'Next availability on ${nextAvailable}';

	/// en: 'loged in successfully!'
	String get logedInSuccessfully => 'loged in successfully!';

	/// en: 'Forgot password'
	String get forgotPassword => 'Forgot password';

	/// en: 'Don’t have an account?'
	String get donTHaveAnAccount => 'Don’t have an account?';

	/// en: 'You can search c ourse, apply course and findscholarship for abroad studies'
	String get authDescreption => 'You can search c ourse, apply course and findscholarship for abroad studies';

	/// en: 'Account created successfully!'
	String get accountCreatedSuccessfully => 'Account created successfully!';

	/// en: 'Please accept the Terms & Privacy Policy'
	String get AcceptTheTermsPrivacy => 'Please accept the Terms & Privacy Policy';

	/// en: 'Doctors'
	String get doctors => 'Doctors';

	/// en: 'Add Doctor'
	String get addDoctor => 'Add Doctor';

	/// en: 'Continue'
	String get kContinue => 'Continue';

	/// en: 'Choose your role'
	String get chooseYourRole => 'Choose your role';

	/// en: 'The selected role determines the experience and available features.'
	String get theSelectedRoleDetermines => 'The selected role determines the experience and available features.';

	/// en: 'Patient'
	String get patient => 'Patient';

	/// en: 'Find doctors, book appointments, and manage your medical records.'
	String get patientRoleDescreption => 'Find doctors, book appointments, and manage your medical records.';

	/// en: 'Admin'
	String get admin => 'Admin';

	/// en: 'Manage doctors, appointments, users, and the platform.'
	String get adminRoleDescription => 'Manage doctors, appointments, users, and the platform.';

	/// en: 'New Password'
	String get newPassword => 'New Password';

	/// en: 'Re-enter Password'
	String get reEnterPassword => 'Re-enter Password';

	/// en: 'Update Password'
	String get updatePassword => 'Update Password';

	/// en: 'Set the new password for your account so you can login and access all the features.'
	String get setTheNewPasswordFor => 'Set the new password for your account so you can login and access all the features.';

	/// en: 'Reset Password'
	String get resetPassword => 'Reset Password';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Get Started'
	String get getStarted => 'Get Started';

	/// en: 'The email address is already in use by another account.'
	String get theEmailAddressIsAlreadyInUseByAnotherAccount => 'The email address is already in use by another account.';

	/// en: 'The email address is already in use by another account.'
	String get EmailAddressAlreadyInUse => 'The email address is already in use by another account.';

	/// en: 'The email address is not valid.'
	String get EmailAddressNotValid => 'The email address is not valid.';

	/// en: 'The password provided is too weak.'
	String get thePasswordisWeak => 'The password provided is too weak.';

	/// en: 'An unknown authentication error occurred.'
	String get anUnknownAuthError => 'An unknown authentication error occurred.';

	/// en: 'Email/password accounts are not enabled.'
	String get AccountsAreNotEnabled => 'Email/password accounts are not enabled.';

	/// en: 'You can search c ourse, apply course and findscholarship for abroad studies'
	String get youCanSearchCOurse => 'You can search c ourse, apply course and findscholarship for abroad studies';

	/// en: 'Access denied.'
	String get accessDenied => 'Access denied.';

	/// en: 'Settings Screen'
	String get settingsScreen => 'Settings Screen';

	/// en: 'count'
	String get count => 'count';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Cardiologist'
	String get cardiologist => 'Cardiologist';

	/// en: 'Orthopedic'
	String get orthopedic => 'Orthopedic';

	/// en: 'Dentist'
	String get dentist => 'Dentist';

	/// en: 'Active Doctors'
	String get activeDoctors => 'Active Doctors';

	/// en: 'Total Doctors'
	String get totalDoctors => 'Total Doctors';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Inactive'
	String get inactive => 'Inactive';

	/// en: 'Enter 4 Digits Code'
	String get enter_4DigitsCode => 'Enter 4 Digits Code';

	/// en: 'Enter the 4 digits code that you received on your email.'
	String get enterTheCodeThatYouReceived => 'Enter the 4 digits code that you received on your email.';

	/// en: 'Enter your email for the verification process, we will send 4 digits code to your email.'
	String get enterYourEmailForTheVerification => 'Enter your email for the verification process, we will send 4 digits code to your email.';

	/// en: 'Runing'
	String get runing => 'Runing';

	/// en: 'Ongoing'
	String get ongoing => 'Ongoing';

	/// en: 'Favourite Doctors'
	String get favouriteDoctors => 'Favourite Doctors';

	/// en: 'Find Doctors'
	String get findDoctors => 'Find Doctors';

	/// en: 'Profile picture updated successfully!'
	String get profilePictureUpdatedSuccessfully => 'Profile picture updated successfully!';

	/// en: 'Create Doctor'
	String get createDoctor => 'Create Doctor';

	/// en: 'Doctor Name'
	String get doctorName => 'Doctor Name';

	/// en: 'Medical Specialty'
	String get medicalSpecialty => 'Medical Specialty';

	/// en: 'Add Photo'
	String get addPhoto => 'Add Photo';

	/// en: 'Select Specialty'
	String get selectSpecialty => 'Select Specialty';

	/// en: 'e.g. Dr. Ahmed Ali'
	String get eGDrAhmedAli => 'e.g. Dr. Ahmed Ali';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'live' => 'LIVE',
			'doctor_hunt' => 'Doctor Hunt',
			'doctorDetails' => 'Doctor Details',
			'findYourDoctor' => 'Find Your Doctor',
			'search' => 'Search.....',
			'nextAvailable' => 'Next Available',
			'bookNow' => 'Book Now',
			'popularDoctors' => 'Popular Doctors',
			'seeAll' => 'See all',
			'featureDoctor' => 'Feature Doctor',
			'liveDoctors' => 'Live Doctors',
			'selectTime' => 'Select Time',
			'noSlotsAvailable' => 'No slots available',
			'or' => 'OR',
			'contactClinic' => 'Contact Clinic',
			'eveningSlots' => ({required Object length}) => 'Evening ${length} slots',
			'afternoonSlots' => ({required Object length}) => 'Afternoon ${length} slots',
			'password' => 'Password',
			'email' => 'Email',
			'name' => 'Name',
			'facebook' => 'Facebook',
			'google' => 'Google',
			'user' => 'User',
			'haveAnAccount' => 'Have an account?',
			'logIn' => 'Log in',
			'signUp' => 'Sign up',
			'iAgreeWithTheTerms' => 'I agree with the Terms of Service & Privacy Policy',
			'joinUs' => 'Join us',
			'hi' => ({required Object userName}) => 'Hi ${userName}!',
			'welcomeBack' => 'Welcome back',
			'enterYourName' => 'Enter your Name',
			'enterYourEmail' => 'Enter your email',
			'enterYourPassword' => 'Enter your Password',
			'passwordMustBe' => 'password must be at least 8 characters',
			'nextAvailabilityOn' => ({required Object nextAvailable}) => 'Next availability on ${nextAvailable}',
			'logedInSuccessfully' => 'loged in successfully!',
			'forgotPassword' => 'Forgot password',
			'donTHaveAnAccount' => 'Don’t have an account?',
			'authDescreption' => 'You can search c ourse, apply course and findscholarship for abroad studies',
			'accountCreatedSuccessfully' => 'Account created successfully!',
			'AcceptTheTermsPrivacy' => 'Please accept the Terms & Privacy Policy',
			'doctors' => 'Doctors',
			'addDoctor' => 'Add Doctor',
			'kContinue' => 'Continue',
			'chooseYourRole' => 'Choose your role',
			'theSelectedRoleDetermines' => 'The selected role determines the experience and available features.',
			'patient' => 'Patient',
			'patientRoleDescreption' => 'Find doctors, book appointments, and manage your medical records.',
			'admin' => 'Admin',
			'adminRoleDescription' => 'Manage doctors, appointments, users, and the platform.',
			'newPassword' => 'New Password',
			'reEnterPassword' => 'Re-enter Password',
			'updatePassword' => 'Update Password',
			'setTheNewPasswordFor' => 'Set the new password for your account so you can login and access all the features.',
			'resetPassword' => 'Reset Password',
			'skip' => 'Skip',
			'getStarted' => 'Get Started',
			'theEmailAddressIsAlreadyInUseByAnotherAccount' => 'The email address is already in use by another account.',
			'EmailAddressAlreadyInUse' => 'The email address is already in use by another account.',
			'EmailAddressNotValid' => 'The email address is not valid.',
			'thePasswordisWeak' => 'The password provided is too weak.',
			'anUnknownAuthError' => 'An unknown authentication error occurred.',
			'AccountsAreNotEnabled' => 'Email/password accounts are not enabled.',
			'youCanSearchCOurse' => 'You can search c ourse, apply course and findscholarship for abroad studies',
			'accessDenied' => 'Access denied.',
			'settingsScreen' => 'Settings Screen',
			'count' => 'count',
			'all' => 'All',
			'cardiologist' => 'Cardiologist',
			'orthopedic' => 'Orthopedic',
			'dentist' => 'Dentist',
			'activeDoctors' => 'Active Doctors',
			'totalDoctors' => 'Total Doctors',
			'active' => 'Active',
			'inactive' => 'Inactive',
			'enter_4DigitsCode' => 'Enter 4 Digits Code',
			'enterTheCodeThatYouReceived' => 'Enter the 4 digits code that you received on your email.',
			'enterYourEmailForTheVerification' => 'Enter your email for the verification process, we will send 4 digits code to your email.',
			'runing' => 'Runing',
			'ongoing' => 'Ongoing',
			'favouriteDoctors' => 'Favourite Doctors',
			'findDoctors' => 'Find Doctors',
			'profilePictureUpdatedSuccessfully' => 'Profile picture updated successfully!',
			'createDoctor' => 'Create Doctor',
			'doctorName' => 'Doctor Name',
			'medicalSpecialty' => 'Medical Specialty',
			'addPhoto' => 'Add Photo',
			'selectSpecialty' => 'Select Specialty',
			'eGDrAhmedAli' => 'e.g. Dr. Ahmed Ali',
			_ => null,
		};
	}
}
