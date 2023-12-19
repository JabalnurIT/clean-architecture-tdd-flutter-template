import 'dart:io';

import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/repositories/auth_repository.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/add_photo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late AuthRepository repository;
  late AddPhoto usecase;

  const tType = 'camera';
  final tFile = File('path');

  setUp(() {
    repository = MockAuthRepo();
    usecase = AddPhoto(repository);
  });

  test(
    'should call the [AuthRepo.addPhoto]',
    () async {
      when(
        () => repository.addPhoto(
          type: tType,
        ),
      ).thenAnswer(
        (_) async => Right(tFile),
      );

      final result = await usecase(tType);

      expect(result, equals(Right<dynamic, File>(tFile)));

      verify(() => repository.addPhoto(type: tType)).called(1);
      verifyNoMoreInteractions(repository);
    },
  );
}
