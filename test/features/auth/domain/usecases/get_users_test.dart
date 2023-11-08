import 'package:clean_architecute_bloc/features/auth/domain/entities/user_data.dart';
import 'package:clean_architecute_bloc/features/auth/domain/repositories/authentication_repository.dart';
import 'package:clean_architecute_bloc/features/auth/domain/usecases/get_users.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_reposityry.mock.dart';

void main() {
  late GetUsers useCases;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    useCases = GetUsers(repository);
  });

  const tResponse = [UserData.empty()];

  test("should call [AuthRepo.getUsers] and return [List<UserData>]", () async {
    //
    when(() => repository.getUsers()).thenAnswer(
      (_) async => const Right(tResponse),
    );

    final result = await useCases();
    expect(result, equals(const Right<dynamic, List<UserData>>(tResponse)));

    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
