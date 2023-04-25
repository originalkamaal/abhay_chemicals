part of 'auth_bloc.dart';

class AuthState {
  final String email;
  final String password;
  final String phone;
  final String name;
  final List<String> passwordError;
  final List<String> emailError;
  final List<String> nameError;

  AuthState(
      {this.email = "",
      this.password = "",
      this.phone = "",
      this.name = "",
      this.passwordError = const [],
      this.nameError = const [],
      this.emailError = const []});

  AuthState copyWith(
      {String? email,
      String? password,
      String? mobile,
      List<String>? passwordError,
      List<String>? emailError,
      List<String>? nameError,
      String? name}) {
    return AuthState(
        email: email ?? this.email,
        password: password ?? this.password,
        phone: mobile ?? phone,
        passwordError: passwordError ?? this.passwordError,
        emailError: emailError ?? this.emailError,
        nameError: nameError ?? this.nameError,
        name: name ?? this.name);
  }
}
