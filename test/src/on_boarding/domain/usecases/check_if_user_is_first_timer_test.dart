import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_architecture_tdd_flutter_template/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:clean_architecture_tdd_flutter_template/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';

import 'on_boarding_repository.mock.dart';

void main() {
  late OnBoardingRepository repository;
  late CheckIfUserIsFirstTimer usecase;

  setUp(() async {
    repository = MockOnBoardingRepo();
    usecase = CheckIfUserIsFirstTimer(repository);
  });

  test(
    'should get a response from the [OnBoardingRepo.checkIfUserIsFirstTime]',
    () async {
      when(() => repository.checkIfUserIsFirstTimer()).thenAnswer(
        (_) async => const Right(true),
      );

      final result = await usecase();

      expect(
        result,
        equals(
          const Right<dynamic, bool>(true),
        ),
      );

      verify(() => repository.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
