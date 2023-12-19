import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/sign_out.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late SignOut usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignOut(repository);
  });

  test(
    'should call the [AuthRepo.signOut]',
    () async {
      when(
        () => repository.signOut(),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase();

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => repository.signOut()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
