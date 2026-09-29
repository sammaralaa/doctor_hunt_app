enum UserRole { 
  patient, 
  admin;

  static UserRole fromString(String roleString) {
    return UserRole.values.asNameMap()[roleString] ?? UserRole.patient;
  }
}