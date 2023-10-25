import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_architecture_tdd_flutter_template/core/errors/exceptions.dart';
import 'package:clean_architecture_tdd_flutter_template/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences sharedPreferences;
  late OnBoardingLocalDataSource localDataSource;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSource = OnBoardingLocalDataSourceImpl(sharedPreferences);
  });

  group(
    'cacheFirstTime',
    () {
      test(
        'should call [SharedPreferences] to cache the data',
        () async {
          when(() => sharedPreferences.setBool(any(), any()))
              .thenAnswer((_) async => true);

          await localDataSource.cacheFirstTimer();

          verify(() => sharedPreferences.setBool(kIsFirstTimerKey, false))
              .called(1);
          verifyNoMoreInteractions(sharedPreferences);
        },
      );

      test(
        'should throw a [CacheException] when there is an error caching the data',
        () async {
          when(() => sharedPreferences.setBool(any(), any())).thenThrow(
            Exception(),
          );

          final methodCall = localDataSource.cacheFirstTimer;

          expect(
            methodCall,
            throwsA(
              isA<CacheException>(),
            ),
          );
          verify(() => sharedPreferences.setBool(kIsFirstTimerKey, false))
              .called(1);
          verifyNoMoreInteractions(sharedPreferences);
        },
      );
    },
  );

  group(
    'CheckIfUserIsFirstTimer',
    () {
      test(
        'should call [SharedPreferences] to check if user is first timer and'
        'return the right response from storage when data exists',
        () async {
          when(() => sharedPreferences.getBool(any())).thenReturn(false);

          final result = await localDataSource.checkIfUserIsFirstTimer();

          expect(result, equals(false));
          verify(() => sharedPreferences.getBool(kIsFirstTimerKey)).called(1);
          verifyNoMoreInteractions(sharedPreferences);
        },
      );

      test(
        'should return true if there is no data in storage',
        () async {
          when(() => sharedPreferences.getBool(any())).thenReturn(null);

          final result = await localDataSource.checkIfUserIsFirstTimer();

          expect(result, equals(true));
          verify(() => sharedPreferences.getBool(kIsFirstTimerKey)).called(1);
          verifyNoMoreInteractions(sharedPreferences);
        },
      );

      test(
        'should throw a [CacheException] when there is an error retrieving the data',
        () async {
          when(() => sharedPreferences.getBool(any())).thenThrow(
            Exception(),
          );

          final methodCall = localDataSource.checkIfUserIsFirstTimer;

          expect(
            methodCall,
            throwsA(
              isA<CacheException>(),
            ),
          );
          verify(() => sharedPreferences.getBool(kIsFirstTimerKey)).called(1);
          verifyNoMoreInteractions(sharedPreferences);
        },
      );
    },
  );
}
