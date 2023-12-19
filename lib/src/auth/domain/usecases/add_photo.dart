import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/auth_repository.dart';

class AddPhoto implements UsecaseWithParams<dynamic, String> {
  const AddPhoto(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<dynamic> call(String type) => _repository.addPhoto(
        type: type,
      );
}
