import 'package:clean_architecture_tdd_flutter_template/core/enums/update_user_action.dart';
import 'package:clean_architecture_tdd_flutter_template/core/utils/typedef.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/entities/user.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<void> forgotPassword(String email);

  ResultFuture<LocalUser> signIn({
    required String username,
    required String password,
  });

  ResultFuture<void> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
  });

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
