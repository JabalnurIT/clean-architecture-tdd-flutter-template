import 'package:equatable/equatable.dart';

import '../../../../core/enums/update_user_action.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class UpdateUser implements UsecaseWithParams<User, UpdateUserParams> {
  const UpdateUser(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<User> call(UpdateUserParams params) => _repository.updateUser(
        actions: params.actions,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.actions,
    required this.userData,
  });

  UpdateUserParams.empty()
      : actions = [UpdateUserAction.email],
        userData = const User.empty();

  final List<UpdateUserAction> actions;
  final User userData;

  @override
  List<Object?> get props => [actions, userData];
}
