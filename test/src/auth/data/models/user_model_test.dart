import 'dart:convert';
import 'package:clean_architecture_tdd_flutter_template/core/utils/typedef.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/data/models/user_model.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tUserModel = UserModel.empty();

  test('should be a subclass of [User] entity',
      () => expect(tUserModel, isA<User>()));

  final tMap = jsonDecode(fixture('user.json')) as DataMap;
  group('fromMap', () {
    test('should return a valid [UserModel] from the Map', () {
      final result = UserModel.fromMap(tMap);

      expect(result, equals(tUserModel));
    });

    test('should throw an Error when the map is invalid ', () {
      final map = DataMap.from(tMap)..remove('id');

      const call = UserModel.fromMap;

      expect(() => call(map), throwsA(isA<Error>()));
    });
  });
  group('toMap', () {
    test('should return a valid [DataMap] from the model', () {
      final result = tUserModel.toMap();

      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test('should return a valid [DataModel] with updated value', () {
      final result = tUserModel.copyWith(
        email: 'email',
        name: 'name',
      );

      expect(
        result.email,
        equals('email'),
      );
      expect(
        result.name,
        equals('name'),
      );
    });
  });
}
