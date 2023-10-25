import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/sign_up.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late SignUp usecase;

  const tUsername = 'username';
  const tPassword = 'password';
  const tEmail = 'email';
  const tName = 'name';

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignUp(repository);
  });

  test(
    'should call the [AuthRepo.forgotPassword]',
    () async {
      when(
        () => repository.signUp(
          name: any(named: 'name'),
          username: any(named: 'username'),
          password: any(named: 'password'),
          email: any(named: 'email'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(
        const SignUpParams(
          username: tUsername,
          password: tPassword,
          email: tEmail,
          name: tName,
        ),
      );

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => repository.signUp(
            username: tUsername,
            password: tPassword,
            email: tEmail,
            name: tName,
          )).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
