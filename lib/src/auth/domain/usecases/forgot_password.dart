import 'package:clean_architecture_tdd_flutter_template/core/usecase/usecase.dart';
import 'package:clean_architecture_tdd_flutter_template/core/utils/typedef.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/repositories/auth_repository.dart';

class ForgotPassword implements UsecaseWithParams<void, String> {
  const ForgotPassword(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(String params) async =>
      _repository.forgotPassword(params);
}
