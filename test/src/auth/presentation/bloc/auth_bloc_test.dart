import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_tdd_flutter_template/core/errors/failure.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/data/models/user_model.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/forgot_password.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/sign_in.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/sign_up.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/domain/usecases/update_user.dart';
import 'package:clean_architecture_tdd_flutter_template/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockUpdateUser extends Mock implements UpdateUser {}

class MockForgotPassword extends Mock implements ForgotPassword {}

void main() {
  late MockSignIn signIn;
  late MockSignUp signUp;
  late MockUpdateUser updateUser;
  late MockForgotPassword forgotPassword;
  late AuthBloc authBloc;

  const tSignUpParams = SignUpParams.empty();
  const tSignInParams = SignInParams.empty();
  const tUpdateUserParams = UpdateUserParams.empty();

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    updateUser = MockUpdateUser();
    forgotPassword = MockForgotPassword();
    authBloc = AuthBloc(
      signIn: signIn,
      signUp: signUp,
      updateUser: updateUser,
      forgotPassword: forgotPassword,
    );
  });

  setUpAll(() {
    registerFallbackValue(tSignUpParams);
    registerFallbackValue(tSignInParams);
    registerFallbackValue(tUpdateUserParams);
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
    const tUser = LocalUserModel.empty();

    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, SignedIn] when [SignInEvent] is added",
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => const Right(tUser));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          SignInEvent(
            username: tSignInParams.username,
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
            username: tSignInParams.username,
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

  group('signUpEvent', () {
    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, SignedUp] when [SignUPEvent] is added and signed up succeeds",
      build: () {
        when(() => signUp(any())).thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          SignUpEvent(
            username: tSignUpParams.username,
            password: tSignUpParams.password,
            email: tSignUpParams.email,
            name: tSignUpParams.name,
          ),
        );
      },
      expect: () => [
        const AuthLoading(),
        const SignedUp(),
      ],
      verify: (_) {
        verify(() => signUp(tSignUpParams)).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, AuthError] when [SignUpEvent] is added and SignUp fails",
      build: () {
        when(() => signUp(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          SignUpEvent(
            username: tSignUpParams.username,
            password: tSignUpParams.password,
            email: tSignUpParams.email,
            name: tSignUpParams.name,
          ),
        );
      },
      expect: () => [
        const AuthLoading(),
        AuthError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => signUp(tSignUpParams)).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );
  });

  group('forgetPasswordEvent', () {
    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, ForgetPasswordSent] when [ForgetPasswordEvent] is added and ForgetPassword succeeds",
      build: () {
        when(() => forgotPassword(any()))
            .thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          const ForgotPasswordEvent(email: 'email'),
        );
      },
      expect: () => [
        const AuthLoading(),
        const ForgotPasswordSent(),
      ],
      verify: (_) {
        verify(() => forgotPassword('email')).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );

    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, AuthError] when [ForgetPasswordEvent] is added and ForgetPassword fails",
      build: () {
        when(() => forgotPassword(any()))
            .thenAnswer((_) async => const Left(tServerFailure));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          const ForgotPasswordEvent(email: 'email'),
        );
      },
      expect: () => [
        const AuthLoading(),
        AuthError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => forgotPassword('email')).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );
  });

  group('updateUserEvent', () {
    blocTest<AuthBloc, AuthState>(
      "should emit [AuthLoading, UserUpdated] when [UserUpdatedEvent] is added and UserUpdated succeeds",
      build: () {
        when(() => updateUser(any()))
            .thenAnswer((_) async => const Right(null));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(
          UpdateUserEvent(
            action: tUpdateUserParams.action,
            userData: tUpdateUserParams.userData,
          ),
        );
      },
      expect: () => [
        const AuthLoading(),
        const UserUpdated(),
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
            action: tUpdateUserParams.action,
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
}
