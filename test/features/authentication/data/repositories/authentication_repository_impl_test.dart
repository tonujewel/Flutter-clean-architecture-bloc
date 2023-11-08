import 'package:clean_architecute_bloc/core/errors/exceptions.dart';
import 'package:clean_architecute_bloc/core/errors/failure.dart';
import 'package:clean_architecute_bloc/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_architecute_bloc/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:clean_architecute_bloc/features/authentication/domain/entities/user_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImpl repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repoImpl = AuthenticationRepositoryImpl(remoteDataSource);
  });

  const tException = ApiException(
    message: "Unknow error occure",
    statusCode: "500",
  );

  const createdAt = "whatever.createdAt";
  const name = "whatever.name";
  const avatar = "whatever.avatar";

  group("createUser", () {
    test(
        "should call the [RemoteDataSource.createUser] and succesfully create user",
        () async {
      // arrange
      when(
        () => remoteDataSource.createUser(
          createdAt: any(named: "createdAt"),
          name: any(named: "name"),
          avatar: any(named: "avatar"),
        ),
      ).thenAnswer((_) async => await Future.value());

      // act

      final result = await repoImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      // assert

      expect(result, equals(const Right(null)));
      verify(
        () => remoteDataSource.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test("should return a [Server failure] when the call to remote", () async {
      // Arrange
      when(() => remoteDataSource.createUser(
          createdAt: any(named: "createdAt"),
          name: any(named: "name"),
          avatar: any(named: "avatar"))).thenThrow(tException);

      // Act

      final result = await repoImpl.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );

      expect(
        result,
        equals(
          Left(
            ApiFailure(
                message: tException.message, statusCode: tException.statusCode),
          ),
        ),
      );

      verify(
        () => remoteDataSource.createUser(
            createdAt: createdAt, name: name, avatar: avatar),
      ).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group("getUsers", () {
    test("should call the [RemoteDataSource.getUsers] and retund user list",
        () async {
      // arrange
      when(() => remoteDataSource.getUsers()).thenAnswer(
        (_) async => [],
      );

      // act
      final result = await repoImpl.getUsers();

      // assert
      expect(result, isA<Right<dynamic, List<UserData>>>());
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test("should return a [ApiFailure] when the call to the remote", () async {
      // Arrange
      when(() => remoteDataSource.getUsers()).thenThrow(tException);

      // Act
      final result = await repoImpl.getUsers();

      // Assert
      expect(result, equals(Left(ApiFailure.fromException(tException))));
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
