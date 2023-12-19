import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/entities/user.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/update_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late UpdateUser usecase;

  final tUpdateUserParams = UpdateUserParams.empty();

  setUp(() {
    repository = MockAuthRepo();
    usecase = UpdateUser(repository);
  });

  const tUser = User.empty();

  setUpAll(() {
    registerFallbackValue(tUser);
  });

  test(
    'should call the [AuthRepo.updateUser]',
    () async {
      when(
        () => repository.updateUser(
          actions: any(named: 'actions'),
          userData: any(named: 'userData'),
        ),
      ).thenAnswer(
        (_) async => const Right(tUser),
      );

      final result = await usecase(
        UpdateUserParams(
          actions: tUpdateUserParams.actions,
          userData: tUpdateUserParams.userData,
        ),
      );

      expect(result, equals(const Right<dynamic, User>(tUser)));

      verify(
        () => repository.updateUser(
          actions: any(named: 'actions'),
          userData: any(named: 'userData'),
        ),
      ).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
