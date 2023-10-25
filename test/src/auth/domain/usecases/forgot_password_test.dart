import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/forgot_password.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late ForgotPassword usecase;

  const tEmail = 'email@example.com';

  setUp(() {
    repository = MockAuthRepo();
    usecase = ForgotPassword(repository);
  });

  test(
    'should call the [AuthRepo.forgotPassword]',
    () async {
      when(
        () => repository.forgotPassword(
          any(),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(
        tEmail,
      );

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => repository.forgotPassword(any())).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
