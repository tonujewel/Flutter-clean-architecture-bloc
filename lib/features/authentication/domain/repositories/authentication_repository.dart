import 'package:clean_architecute_bloc/core/utils/typedef.dart';
import 'package:clean_architecute_bloc/features/authentication/domain/entities/user_data.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<UserData>> getUsers();
}
