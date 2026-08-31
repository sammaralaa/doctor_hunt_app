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

	/// en: 'Join us to start searching'
	String get joinUs => 'Join us to start searching';

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
			'joinUs' => 'Join us to start searching',
			'hi' => ({required Object userName}) => 'Hi ${userName}!',
			'welcomeBack' => 'Welcome back',
			'enterYourName' => 'Enter your Name',
			'enterYourEmail' => 'Enter your email',
			'enterYourPassword' => 'Enter your Password',
			'passwordMustBe' => 'password must be at least 8 characters',
			_ => null,
		};
	}
}
