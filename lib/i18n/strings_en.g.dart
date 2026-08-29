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

	/// en: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'
	String get urlTemp => 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

	/// en: 'doctor_hunt_app.app'
	String get packageName => 'doctor_hunt_app.app';

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
			'urlTemp' => 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
			'packageName' => 'doctor_hunt_app.app',
			'popularDoctors' => 'Popular Doctors',
			'seeAll' => 'See all',
			'featureDoctor' => 'Feature Doctor',
			'liveDoctors' => 'Live Doctors',
			'selectTime' => 'Select Time',
			_ => null,
		};
	}
}
