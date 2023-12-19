import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/auth_repository.dart';

class SignOut implements UsecaseWithoutParams<void> {
  const SignOut(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call() => _repository.signOut();
}
