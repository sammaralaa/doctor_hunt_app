enum DoctorSpecialty {
  cardiology('cardiology', 'Cardiology'),
  dentistry('dentistry','Dentistry'),
  orthopedics('orthopedics', 'Orthopedics'),
  generalMedicine('generalMedicine', 'General Medicine');

  final String key;
  final String displayName;

  const DoctorSpecialty(this.key, this.displayName);

  static DoctorSpecialty fromKey(String key) {
    return DoctorSpecialty.values.firstWhere(
      (element) => element.key.toLowerCase() == key.toLowerCase(),
      orElse: () => DoctorSpecialty.generalMedicine,     );
  }
}