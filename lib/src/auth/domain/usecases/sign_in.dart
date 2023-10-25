import 'package:clean_architecture_tdd_flutter_template/core/usecase/usecase.dart';
import 'package:clean_architecture_tdd_flutter_template/core/utils/typedef.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/entities/user.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignIn implements UsecaseWithParams<LocalUser, SignInParams> {
  const SignIn(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<LocalUser> call(SignInParams params) => _repository.signIn(
        username: params.username,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.username,
    required this.password,
  });

  const SignInParams.empty()
      : username = '',
        password = '';

  final String username;
  final String password;

  @override
  List<Object?> get props => [username, password];
}
