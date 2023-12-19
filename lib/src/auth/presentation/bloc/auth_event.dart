part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInWithCredentialEvent extends AuthEvent {
  const SignInWithCredentialEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class UpdateUserEvent extends AuthEvent {
  const UpdateUserEvent({required this.actions, required this.userData});

  final List<UpdateUserAction> actions;
  final User userData;

  @override
  List<Object> get props => [actions, userData];
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();

  @override
  List<Object> get props => [];
}

class AddPhotoEvent extends AuthEvent {
  const AddPhotoEvent({
    required this.type,
  });

  final String type;

  @override
  List<Object> get props => [type];
}
