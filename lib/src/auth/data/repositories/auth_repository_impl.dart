import 'package:clean_architecture_tdd_flutter_template/core/enums/update_user_action.dart';
import 'package:clean_architecture_tdd_flutter_template/core/errors/exceptions.dart';
import 'package:clean_architecture_tdd_flutter_template/core/errors/failure.dart';
import 'package:clean_architecture_tdd_flutter_template/core/utils/typedef.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/entities/user.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LocalUser> signIn({
    required String username,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(
        username: username,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signUp(
        name: name,
        username: username,
        email: email,
        password: password,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required userData,
  }) async {
    try {
      await _remoteDataSource.updateUser(
        action: action,
        userData: userData,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
