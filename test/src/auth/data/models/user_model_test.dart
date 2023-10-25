import 'dart:convert';

import 'package:clean_architecture_tdd_flutter_template/core/utils/typedef.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/data/models/user_model.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tLocalUserModel = LocalUserModel.empty();

  test('should be a subclass of [LocalUser] entity',
      () => expect(tLocalUserModel, isA<LocalUser>()));

  final tMap = jsonDecode(fixture('user.json')) as DataMap;
  group('fromMap', () {
    test('should return a valid [LocalUserModel] from the Map', () {
      final result = LocalUserModel.fromMap(tMap);

      expect(result, equals(tLocalUserModel));
    });

    test('should throw an [Error] when the map is invalid ', () {
      final map = DataMap.from(tMap)..remove('id');

      const call = LocalUserModel.fromMap;

      expect(() => call(map), throwsA(isA<Error>()));
    });
  });
  group('toMap', () {
    test('should return a valid [DataMap] from the model', () {
      final result = tLocalUserModel.toMap();

      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test('should return a valid [LocalDataModel] with updated value', () {
      final result = tLocalUserModel.copyWith(
        email: 'email',
        username: 'username',
      );

      expect(
        result.email,
        equals('email'),
      );
      expect(
        result.username,
        equals('username'),
      );
    });
  });
}
