part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  const AuthError(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];
}

class SignedIn extends AuthState {
  const SignedIn(
    this.user,
  );

  final User user;

  @override
  List<Object> get props => [user];
}

class NotSignedIn extends AuthState {
  const NotSignedIn();

  @override
  List<Object> get props => [];
}

class UserUpdated extends AuthState {
  const UserUpdated(
    this.user,
  );

  final User user;

  @override
  List<Object> get props => [user];
}

class SignedOut extends AuthState {
  const SignedOut();

  @override
  List<Object> get props => [];
}

class EditUserError extends AuthState {
  const EditUserError(
    this.message,
  );

  final String message;

  @override
  List<Object> get props => [message];
}

class EditUserUpdating extends AuthState {
  const EditUserUpdating();
}

// class DataLoaded extends AuthState {
//   const DataLoaded(this.user);

//   final User user;

//   @override
//   List<Object> get props => [user];
// }

class PhotoProfileAdded extends AuthState {
  const PhotoProfileAdded(this.photo);

  final dynamic photo;

  @override
  List<Object> get props => [photo];
}
