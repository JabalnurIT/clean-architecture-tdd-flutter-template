import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_tdd_flutter_template/core/errors/failure.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/data/models/user_model.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/add_photo.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/sign_in.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/sign_in_with_credential.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/sign_out.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/update_user.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignInWithCredential extends Mock implements SignInWithCredential {}

class MockUpdateUser extends Mock implements UpdateUser {}

class MockSignOut extends Mock implements SignOut {}

class MockAddPhoto extends Mock implements AddPhoto {}

void main() {
  late MockSignIn signIn;
  late MockSignInWithCredential signInWithCredential;
  late MockUpdateUser updateUser;
  late MockSignOut signOut;
  late AuthBloc authBloc;
  late MockAddPhoto addPhoto;

  const tSignInParams = SignInParams.empty();
  final tUpdateUserParams = UpdateUserParams.empty();
  final tFile = File('test');

  setUp(() {
    signIn = MockSignIn();
    signInWithCredential = MockSignInWithCredential();
    updateUser = MockUpdateUser();
    signOut = MockSignOut();
    addPhoto = MockAddPhoto();
    authBloc = AuthBloc(
      signIn: signIn,
      signInWithCredential: signInWithCredential,
      updateUser: updateUser,
      signOut: signOut,
      addPhoto: addPhoto,
    );
  });

  setUpAll(() {
    registerFallbackValue(tSignInParams);
    registerFallbackValue(tUpdateUserParams);
    registerFallbackValue(tFile);
  });

  tearDown(() => authBloc.close());

  test('InitialState must be [AuthInitial]', () {
    expect(authBloc.state, const AuthInitial());
  });

  const tServerFailure = ServerFailure(
    message:
        'There is no user record corresponding to this identifier. The user may have been deleted.',
    statusCode: '404',
  );

  group('signInEvent', () {
    const tUser = UserModel.empty();

    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, SignedIn] when [SignInEvent] is added",
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          SignInEvent(
            email: tSignInParams.email,
            password: tSignInParams.password,
          ),
        );
      },
      expect: () => [
        const AuthLoading(),
        const SignedIn(tUser),
      ],
      verify: (_) {
        verify(() => signIn(tSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, AuthError] when signIn fails",
      build: () {
        when(() => signIn(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          SignInEvent(
            email: tSignInParams.email,
            password: tSignInParams.password,
          ),
        );
      },
      expect: () => [
        const AuthLoading(),
        AuthError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => signIn(tSignInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
  });

  group('updateUserEvent', () {
    const tUser = UserModel.empty();
    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, UserUpdated] when [UserUpdatedEvent] is added and UserUpdated succeeds",
      build: () {
        when(() => updateUser(any()))
            .thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          UpdateUserEvent(
            actions: tUpdateUserParams.actions,
            userData: tUpdateUserParams.userData,
          ),
        );
      },
      expect: () => [
        const AuthLoading(),
        const UserUpdated(tUser),
      ],
      verify: (_) {
        verify(() => updateUser(tUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, AuthError] when [UserUpdatedEvent] is added and UserUpdated fails",
      build: () {
        when(() => updateUser(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          UpdateUserEvent(
            actions: tUpdateUserParams.actions,
            userData: tUpdateUserParams.userData,
          ),
        );
      },
      expect: () => [
        const AuthLoading(),
        AuthError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => updateUser(tUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );
  });

  group('SignInWithCredential', () {
    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, SignedIn] when [SignInWithCredentialEvent] is added",
      build: () {
        when(() => signInWithCredential())
            .thenAnswer((_) async => const Right(UserModel.empty()));
        return authBloc;
      },
      act: (bloc) async {
        bloc.add(
          const SignInWithCredentialEvent(),
        );
      },
      expect: () => [
        const AuthLoading(),
        const SignedIn(
          UserModel.empty(),
        ),
      ],
      verify: (_) {
        verify(() => signInWithCredential()).called(1);
        verifyNoMoreInteractions(signInWithCredential);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, NotSignedIn] when [signInWithCredentialEvent] fails",
      build: () {
        when(() => signInWithCredential())
            .thenAnswer((_) async => const Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          const SignInWithCredentialEvent(),
        );
      },
      expect: () => [
        const AuthLoading(),
        const NotSignedIn(),
      ],
      verify: (_) {
        verify(() => signInWithCredential()).called(1);
        verifyNoMoreInteractions(signInWithCredential);
      },
    );
  });

  group('SignOutEvent', () {
    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, NotSignedIn] when [SignOutEvent] is added",
      build: () {
        when(() => signOut()).thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) async {
        bloc.add(
          const SignOutEvent(),
        );
      },
      expect: () => [
        const AuthLoading(),
        const NotSignedIn(),
      ],
      verify: (_) {
        verify(() => signOut()).called(1);
        verifyNoMoreInteractions(signOut);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, AuthError] when [SignOutEvent] fails",
      build: () {
        when(() => signOut())
            .thenAnswer((_) async => const Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          const SignOutEvent(),
        );
      },
      expect: () => [
        const AuthLoading(),
        AuthError(
          tServerFailure.errorMessage,
        ),
      ],
      verify: (_) {
        verify(() => signOut()).called(1);
        verifyNoMoreInteractions(signOut);
      },
    );
  });

  group('AddPhotoEvent', () {
    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, PhotoProfileAdded] when [AddPhotoEvent] is added",
      build: () {
        when(() => addPhoto(any())).thenAnswer((_) async => Right(tFile));
        return authBloc;
      },
      act: (bloc) async {
        bloc.add(
          const AddPhotoEvent(type: "camera"),
        );
      },
      expect: () => [
        const AuthLoading(),
        PhotoProfileAdded(
          tFile,
        ),
      ],
      verify: (_) {
        verify(() => addPhoto(any())).called(1);
        verifyNoMoreInteractions(addPhoto);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, EditUserError] when [AddPhotoEvent] fails",
      build: () {
        when(() => addPhoto(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          const AddPhotoEvent(type: "camera"),
        );
      },
      expect: () => [
        const AuthLoading(),
        EditUserError(
          tServerFailure.errorMessage,
        ),
      ],
      verify: (_) {
        verify(() => addPhoto(any())).called(1);
        verifyNoMoreInteractions(addPhoto);
      },
    );
  });
}
