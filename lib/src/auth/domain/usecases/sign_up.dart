import 'package:clean_architecture_tdd_flutter_template/core/usecase/usecase.dart';
import 'package:clean_architecture_tdd_flutter_template/core/utils/typedef.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignUp implements UsecaseWithParams<void, SignUpParams> {
  const SignUp(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(SignUpParams params) async => _repository.signUp(
        username: params.username,
        password: params.password,
        email: params.email,
        name: params.name,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.username,
    required this.password,
    required this.email,
    required this.name,
  });

  const SignUpParams.empty()
      : username = '',
        name = '',
        password = '',
        email = '';

  final String username;
  final String password;
  final String email;
  final String name;

  @override
  List<Object?> get props => [username, password, email];
}
