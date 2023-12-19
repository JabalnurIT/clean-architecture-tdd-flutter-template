import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/entities/user.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/sign_in_with_credential.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late SignInWithCredential usecase;

  setUp(() {
    repository = MockAuthRepo();
    usecase = SignInWithCredential(repository);
  });

  const tUser = User.empty();

  test(
    'should call the [AuthRepo.signIn]',
    () async {
      when(
        () => repository.signInWithCredential(),
      ).thenAnswer(
        (_) async => const Right(tUser),
      );

      final result = await usecase();

      expect(result, equals(const Right<dynamic, User>(tUser)));

      verify(() => repository.signInWithCredential()).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
