// what dose the class depend on
// how can we create a fake version of the dependency
// how we control what our dependencies do

import 'package:clean_architecute_bloc/features/auth/domain/repositories/authentication_repository.dart';
import 'package:clean_architecute_bloc/features/auth/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_reposityry.mock.dart';


void main() {
  late CreateUser useCases;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    useCases = CreateUser(repository);
  });

  const params = CreateUserParams.empty();

  test("should call the [AuthRepo.call]", () async {
    // Arrange
    // STUB
    when(
      () => repository.createUser(
        createdAt: any(named: "createdAt"),
        name: any(named: "name"),
        avatar: any(named: "avatar"),
      ),
    ).thenAnswer((_) async => const Right(null));

    // Act
    final result = await useCases(params);
    // Assert

    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      ),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
