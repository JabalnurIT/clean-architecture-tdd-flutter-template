import 'package:dartz/dartz.dart';
import 'package:clean_architecture_tdd_flutter_template/core/errors/exceptions.dart';
import 'package:clean_architecture_tdd_flutter_template/core/errors/failure.dart';
import 'package:clean_architecture_tdd_flutter_template/core/utils/typedef.dart';
import 'package:clean_architecture_tdd_flutter_template/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:clean_architecture_tdd_flutter_template/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class OnBoardingRepositoryImpl implements OnBoardingRepository {
  const OnBoardingRepositoryImpl(this._localDataSource);

  final OnBoardingLocalDataSource _localDataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(
        CacheFailure.fromException(e),
      );
    }
  }
}
