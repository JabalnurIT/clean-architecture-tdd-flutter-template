import 'package:clean_architecture_tdd_flutter_template/core/enums/update_user_action.dart';
import 'package:clean_architecture_tdd_flutter_template/core/errors/exceptions.dart';
import 'package:clean_architecture_tdd_flutter_template/core/utils/constanst.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:clean_architecture_tdd_flutter_template/core/services/api.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockDio extends Mock implements Dio {}

void main() {
  late SharedPreferences sharedPreferences;
  late Dio dio;
  late API api;
  late AuthRemoteDataSourceImpl dataSource;
  const tUser = UserModel.empty();

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    dio = MockDio();
    api = API();
    dataSource = AuthRemoteDataSourceImpl(
      sharedPreferences: sharedPreferences,
      dio: dio,
      api: api,
    );
  });

  const tPassword = 'password';
  const tEmail = 'email@admin.com';
  const tToken = 'token';

  final tResponseFailed = Response(
    data: {
      'message': 'ServerException',
      'user': null,
    },
    statusCode: 500,
    requestOptions: RequestOptions(path: ''),
  );
  const String tModifiedProfileImgUrl = '$kBaseUrl/images/profile/photo.jpg';

  final tResponseSuccess = Response<dynamic>(
    data: {
      'message': 'Success',
      'data': {
        'user': tUser.toMap(),
        'role': 'employee',
        'token': 'token',
      },
    },
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  final tResponseUpdateSuccess = Response<dynamic>(
    data: {
      'data': tUser.toMap(),
    },
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  final tResponseUpdateSuccessWithProfileImg = Response<dynamic>(
    data: {
      'data': {
        'id': 0,
        'name': 'John Doe',
        'email': 'john@example.com',
        'profile_img': 'photo.jpg',
      },
    },
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  final tResponseNoData = Response<dynamic>(
    data: {
      'data': null,
    },
    statusCode: 200,
    requestOptions: RequestOptions(path: ''),
  );

  const tServerException = ServerException(
    message: 'ServerException',
    statusCode: 500,
  );
  group(
    'signIn',
    () {
      test('should complete successfully when no [Exception] is thrown',
          () async {
        when(
          () => dio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => tResponseSuccess);

        when(() => sharedPreferences.setString(any(), any()))
            .thenAnswer((_) async => true);

        final result = await dataSource.signIn(
          email: tEmail,
          password: tPassword,
        );

        expect(result, equals(tUser));

        verify(
          () => dio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);

        verify(() => sharedPreferences.setString(kToken, 'token')).called(1);
        verifyNoMoreInteractions(sharedPreferences);
      });

      test(
        'should throw [ServerException] when user is null after signining in',
        () async {
          when(
            () => dio.post(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenAnswer((_) async => tResponseFailed);

          final call = dataSource.signIn;
          expect(
            () => call(email: tEmail, password: tPassword),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.post(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);
        },
      );

      test('should throw [ServerException] when endpoint is not found',
          () async {
        when(
          () => dio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(tServerException);

        final call = dataSource.signIn;
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );

        verify(
          () => dio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);
      });
    },
  );

  group(
    'signInWithCredential',
    () {
      test('should complete successfully when no [Exception] is thrown',
          () async {
        when(
          () => dio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => tResponseSuccess);

        when(() => sharedPreferences.getString(any())).thenReturn(tToken);

        final result = await dataSource.signInWithCredential();

        expect(result, equals(tUser));

        verify(
          () => dio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);

        verify(() => sharedPreferences.getString(any())).called(1);
        verifyNoMoreInteractions(sharedPreferences);
      });

      test(
        'should throw [ServerException] when user is null after signining in',
        () async {
          when(
            () => dio.post(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).thenAnswer((_) async => tResponseFailed);

          when(() => sharedPreferences.getString(any())).thenReturn(kToken);

          final call = dataSource.signInWithCredential;
          expect(
            () => call(),
            throwsA(isA<ServerException>()),
          );

          verify(
            () => dio.post(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            ),
          ).called(1);
          verifyNoMoreInteractions(dio);

          verify(() => sharedPreferences.getString(any())).called(1);
          verifyNoMoreInteractions(sharedPreferences);
        },
      );

      test('should throw [ServerException] when endpoint is not found',
          () async {
        when(
          () => dio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(tServerException);

        when(() => sharedPreferences.getString(any())).thenReturn(kToken);

        final call = dataSource.signInWithCredential;
        expect(
          () => call(),
          throwsA(isA<ServerException>()),
        );

        verify(
          () => dio.post(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);

        verify(() => sharedPreferences.getString(any())).called(1);
        verifyNoMoreInteractions(sharedPreferences);
      });
    },
  );

  group(
    'updateUser',
    () {
      test('should complete successfully when no [Exception] is thrown',
          () async {
        when(() => sharedPreferences.getString(any())).thenReturn("token");
        when(
          () => dio.put(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => tResponseUpdateSuccess);

        final result = await dataSource.updateUser(
          actions: [UpdateUserAction.name],
          userData: tUser,
        );

        expect(result, equals(tUser));

        verify(
          () => dio.put(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).called(1);
        verifyNoMoreInteractions(dio);

        verify(() => sharedPreferences.getString(any())).called(1);
        verifyNoMoreInteractions(sharedPreferences);
      });

      // Test scenario for poin 2: Not Signed In
      test('should throw ServerException when not signed in', () async {
        // Arrange
        when(() => sharedPreferences.getString(any())).thenReturn(null);

        final call = dataSource.updateUser;
        expect(
          () => call(
            actions: [UpdateUserAction.name],
            userData: tUser,
          ),
          throwsA(isA<ServerException>()),
        );

        verify(() => sharedPreferences.getString(any())).called(1);
        verifyNoMoreInteractions(sharedPreferences);
        verifyZeroInteractions(dio);
      });

// Test scenario for poin 3: Server Exception during Update
      test('should throw ServerException on server error during update',
          () async {
        // Arrange
        when(() => sharedPreferences.getString(any())).thenReturn("token");
        when(
          () => dio.put(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenThrow(tServerException);

        // Act & Assert
        expect(
          () => dataSource.updateUser(
            actions: [UpdateUserAction.name],
            userData: tUser,
          ),
          throwsA(isA<ServerException>().having(
            (e) => e.message,
            'ServerException',
            'ServerException',
          )),
        );

        verify(() => sharedPreferences.getString(any())).called(1);
        verify(() => dio.put(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).called(1);
        verifyNoMoreInteractions(sharedPreferences);
        verifyNoMoreInteractions(dio);
      });

// Test scenario for poin 4: No User Data Returned
      test('should throw ServerException when no user data is returned',
          () async {
        // Arrange
        when(() => sharedPreferences.getString(any())).thenReturn("token");
        when(
          () => dio.put(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => tResponseNoData);

        // Act & Assert
        expect(
          () => dataSource.updateUser(
            actions: [UpdateUserAction.name],
            userData: tUser,
          ),
          throwsA(isA<ServerException>().having(
            (e) => e.message,
            'Please try again later',
            'Please try again later',
          )),
        );

        verify(() => sharedPreferences.getString(any())).called(1);
        verify(() => dio.put(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).called(1);
        verifyNoMoreInteractions(sharedPreferences);
        verifyNoMoreInteractions(dio);
      });

// Test scenario for poin 5: Profile Image Handling
      test('should handle profile image URL during update', () async {
        // Arrange
        when(() => sharedPreferences.getString(any())).thenReturn("token");
        when(
          () => dio.put(
            any(),
            data: any(named: 'data'),
            options: any(named: 'options'),
          ),
        ).thenAnswer((_) async => tResponseUpdateSuccessWithProfileImg);

        // Act
        final result = await dataSource.updateUser(
          actions: [UpdateUserAction.profileImg],
          userData: tUser,
        );

        // Assert
        expect(result.profileImg, isNotNull);
        expect(result.profileImg, tModifiedProfileImgUrl);

        verify(() => sharedPreferences.getString(any())).called(1);
        verify(() => dio.put(
              any(),
              data: any(named: 'data'),
              options: any(named: 'options'),
            )).called(1);
        verifyNoMoreInteractions(sharedPreferences);
        verifyNoMoreInteractions(dio);
      });
    },
  );
}
