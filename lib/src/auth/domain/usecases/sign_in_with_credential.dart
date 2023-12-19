import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInWithCredential implements UsecaseWithoutParams<User> {
  const SignInWithCredential(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<User> call() => _repository.signInWithCredential();
}
