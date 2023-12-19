import '../../../../core/enums/update_user_action.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<User> signIn({
    required String email,
    required String password,
  });

  ResultFuture<User> signInWithCredential();

  ResultFuture<User> updateUser({
    required List<UpdateUserAction> actions,
    required User userData,
  });

  ResultFuture<void> signOut();

  ResultFuture<dynamic> addPhoto({
    required String type,
  });
}
