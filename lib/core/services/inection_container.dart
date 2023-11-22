import 'package:clean_architecute_bloc/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_architecute_bloc/features/auth/domain/usecases/create_user.dart';
import 'package:clean_architecute_bloc/features/auth/domain/usecases/get_users.dart';
import 'package:clean_architecute_bloc/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/datasources/auth_remote_data_src.dart';
import '../../features/auth/domain/repositories/authentication_repository.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
  // App login
    ..registerFactory(() => AuthCubit(createUser: sl(), getUsers: sl()))

    // Use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // repositories
    ..registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepositoryImpl(sl()))

    // Data sources
    ..registerLazySingleton<AuthRemoteDataSrc>(() => AuthRemoteDataSrcImpl(sl()))

    // external dependencies
    ..registerLazySingleton(http.Client.new);
}
