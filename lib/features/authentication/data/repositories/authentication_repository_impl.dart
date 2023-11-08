import 'package:clean_architecute_bloc/core/errors/exceptions.dart';
import 'package:clean_architecute_bloc/core/errors/failure.dart';
import 'package:clean_architecute_bloc/core/utils/typedef.dart';
import 'package:clean_architecute_bloc/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_architecute_bloc/features/authentication/domain/entities/user_data.dart';
import 'package:clean_architecute_bloc/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  const AuthenticationRepositoryImpl(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // TDD : Test Driven Dovelopment
    // Cal the remote data source
    // make sure that it return proper data if there is no exception
    // check if the method return the proper data
    // check when then remote data source throws an exception we return a failure and Don't throw exception, return the accual value;
    // expect data

    try {
      await _remoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }

    return const Right(null);
  }

  @override
  ResultFuture<List<UserData>> getUsers() async {
    try {
      final result = await _remoteDataSource.getUsers();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
