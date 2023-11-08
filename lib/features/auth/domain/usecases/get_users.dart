import '../../../../core/usecases/usecases.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/authentication_repository.dart';

import '../entities/user_data.dart';

class GetUsers extends UsecaseWithoutParams<List<UserData>> {
  final AuthenticationRepository _repository;
  const GetUsers(this._repository);

  @override
  ResultFuture<List<UserData>> call() async {
    return await _repository.getUsers();
  }
}
