import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecute_bloc/core/errors/failure.dart';
import 'package:clean_architecute_bloc/features/auth/domain/usecases/create_user.dart';
import 'package:clean_architecute_bloc/features/auth/domain/usecases/get_users.dart';
import 'package:clean_architecute_bloc/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthCubit cubit;

  const tCreateUserParam = CreateUserParams.empty();
  const tApiFailure = ApiFailure(message: "message", statusCode: 500);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParam);
  });

  tearDown(() => cubit.close());

  test("initial state sholud be [AuthInitial]", () {
    expect(cubit.state, const AuthInitial());
  });

  group("create user", () {
    blocTest<AuthCubit, AuthState>(
        "should be emit [CreatingUserState, UserCreated] when successful",
        build: () {
          when(() => createUser(any())).thenAnswer(
            (_) async => const Right(null),
          );
          return cubit;
        },
        // for cubit
        act: (cubit) => cubit.createUser(
              createdAt: tCreateUserParam.createdAt,
              name: tCreateUserParam.name,
              avatar: tCreateUserParam.avatar,
            ),
        // for bloc
        // act: (bloc) => bloc.createUser(
        //   createdAt: "createdAt",
        //   name: "name",
        //   avatar: "avatar",
        // ),
        expect: () => [
              const CreatingUserState(),
              const UserCreatedState(),
            ],
        verify: (_) {
          verify(() => createUser(tCreateUserParam)).called(1);
          verifyNoMoreInteractions(createUser);
        });

    blocTest<AuthCubit, AuthState>(
        "should be emit [CreatingUserState, AutheticationErrorState] when unsuccessful",
        build: () {
          when(() => createUser(any())).thenAnswer(
            (_) async => const Left(tApiFailure),
          );
          return cubit;
        },
        act: (cubit) async => cubit.createUser(
              createdAt: tCreateUserParam.createdAt,
              name: tCreateUserParam.name,
              avatar: tCreateUserParam.avatar,
            ),
        expect: () => [
              const CreatingUserState(),
              AutheticationErrorState(message: "${tApiFailure.statusCode} ${tApiFailure.message}"),
            ],
        verify: (_) {
          verify(() => createUser(tCreateUserParam)).called(1);
          verifyNoMoreInteractions(createUser);
        });
  });

  group("getUser", () {
    blocTest(
      "should emit [GettingUsersState, UserLoadedState] when success",
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => [
        const GettingUsersState(),
        const UserLoadedState([]),
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
    blocTest(
      "should emit [GettingUsersState, AutheticationErrorState] when unsuccess",
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Left(tApiFailure));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => [
        const GettingUsersState(),
        AutheticationErrorState(message: tApiFailure.message),
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
