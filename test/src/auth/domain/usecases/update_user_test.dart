import 'package:clean_architecture_tdd_flutter_template/core/enums/update_user_action.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/update_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late UpdateUser usecase;

  const tAction = UpdateUserAction.email;
  const tUserData = <String, dynamic>{
    'email': 'coba@example.com',
  };

  setUp(() {
    repository = MockAuthRepo();
    usecase = UpdateUser(repository);
    registerFallbackValue(UpdateUserAction.email);
  });

  test(
    'should call the [AuthRepo.forgotPassword]',
    () async {
      when(
        () => repository.updateUser(
          action: any(named: 'action'),
          userData: any(named: 'userData'),
        ),
      ).thenAnswer(
        (_) async => const Right(null),
      );

      final result = await usecase(
        const UpdateUserParams(
          action: tAction,
          userData: tUserData,
        ),
      );

      expect(result, equals(const Right<dynamic, void>(null)));

      verify(() => repository.updateUser(
            action: tAction,
            userData: tUserData,
          )).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
