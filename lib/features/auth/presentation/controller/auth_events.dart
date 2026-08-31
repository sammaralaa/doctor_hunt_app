import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequestedEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const SignUpRequestedEvent({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password, name];
}
class LogInRequestedEvent extends AuthEvent {
  final String email;
  final String password;

  const LogInRequestedEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}