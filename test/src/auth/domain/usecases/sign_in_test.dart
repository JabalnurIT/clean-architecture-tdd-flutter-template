import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/entities/user.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late SignIn usecase;

  const tUsername = 'username';
  const tPassword = 'password';

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignIn(repository);
  });

  const tUser = LocalUser.empty();

  test(
    'should call the [AuthRepo.forgotPassword]',
    () async {
      when(
        () => repository.signIn(
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => const Right(tUser),
      );

      final result = await usecase(
        const SignInParams(
          username: tUsername,
          password: tPassword,
        ),
      );

      expect(result, equals(const Right<dynamic, LocalUser>(tUser)));

      verify(() => repository.signIn(username: tUsername, password: tPassword))
          .called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
