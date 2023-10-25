import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_architecture_tdd_flutter_template/core/errors/exceptions.dart';
import 'package:clean_architecture_tdd_flutter_template/core/errors/failure.dart';
import 'package:clean_architecture_tdd_flutter_template/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:clean_architecture_tdd_flutter_template/src/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:clean_architecture_tdd_flutter_template/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class MockOnBoardingLocalDataSource extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBoardingRepositoryImpl repoImpl;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSource();
    repoImpl = OnBoardingRepositoryImpl(localDataSource);
  });

  test(
    'should be a subclass of [OnBoardingRepository]',
    () {
      expect(repoImpl, isA<OnBoardingRepository>());
    },
  );

  group(
    'cacheFirstTime',
    () {
      test(
        'should complete successfully when call to local source is successful',
        () async {
          when(() => localDataSource.cacheFirstTimer())
              .thenAnswer((_) async => Future.value());

          final result = await repoImpl.cacheFirstTimer();

          expect(result, equals(const Right<dynamic, void>(null)));
          verify(() => localDataSource.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(localDataSource);
        },
      );

      test(
        'should return [CacheFailure] when call to local source is unsuccessful',
        () async {
          when(() => localDataSource.cacheFirstTimer()).thenThrow(
            const CacheException(message: 'Insufficient storage'),
          );

          final result = await repoImpl.cacheFirstTimer();

          expect(
            result,
            const Left<CacheFailure, dynamic>(
              CacheFailure(
                message: 'Insufficient storage',
                statusCode: 500,
              ),
            ),
          );

          verify(() => localDataSource.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(localDataSource);
        },
      );
    },
  );

  group(
    'checkIfUserIsFirstTimer',
    () {
      test(
        'should return the right response from storage when data exists',
        () async {
          when(() => localDataSource.checkIfUserIsFirstTimer())
              .thenAnswer((_) async => Future.value(false));

          final result = await repoImpl.checkIfUserIsFirstTimer();

          expect(result, equals(const Right<dynamic, bool>(false)));
          verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(localDataSource);
        },
      );

      test(
        'should return true if there is no data in storage',
        () async {
          when(() => localDataSource.checkIfUserIsFirstTimer())
              .thenAnswer((_) async => Future.value(true));

          final result = await repoImpl.checkIfUserIsFirstTimer();

          expect(result, equals(const Right<dynamic, bool>(true)));
          verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(localDataSource);
        },
      );

      test(
        'should return [CacheFailure] when call to local source is unsuccessful',
        () async {
          when(() => localDataSource.checkIfUserIsFirstTimer()).thenThrow(
            const CacheException(message: 'Insufficient storage'),
          );

          final result = await repoImpl.checkIfUserIsFirstTimer();

          expect(
            result,
            const Left<CacheFailure, dynamic>(
              CacheFailure(
                message: 'Insufficient storage',
                statusCode: 500,
              ),
            ),
          );

          verify(() => localDataSource.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(localDataSource);
        },
      );
    },
  );
}
