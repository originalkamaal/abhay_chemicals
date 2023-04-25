part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class LoginEmailEvent extends AuthEvent {
  final String email;
  const LoginEmailEvent(this.email);
}

class LoginPasswordEvent extends AuthEvent {
  final String password;
  const LoginPasswordEvent(this.password);
}

class RegisterMobileEvent extends AuthEvent {
  final String number;
  const RegisterMobileEvent(this.number);
}

class RegisterEmailEvent extends AuthEvent {
  final String email;
  const RegisterEmailEvent(this.email);
}

class RegisterNameEvent extends AuthEvent {
  final String name;
  const RegisterNameEvent(this.name);
}
