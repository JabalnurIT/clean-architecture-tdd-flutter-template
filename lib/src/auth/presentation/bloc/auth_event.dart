part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [email];
}

class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
  });

  final String username;
  final String password;
  final String email;
  final String name;

  @override
  List<Object> get props => [username, password, email, name];
}

class UpdateUserEvent extends AuthEvent {
  UpdateUserEvent({required this.action, required this.userData})
      : assert(
          userData is String || userData is File,
          'userData must be a String or a File, but was ${userData.runtimeType}',
        );

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object> get props => [action, userData];
}
