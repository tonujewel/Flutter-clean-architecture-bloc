import '../../../../core/usecases/usecases.dart';
import '../../../../core/utils/typedef.dart';
import 'package:equatable/equatable.dart';

import '../repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _repository;

  const CreateUser(this._repository);

  @override
  ResultFuture<void> call(CreateUserParams params) async {
    return _repository.createUser(
      createdAt: params.createdAt,
      name: params.name,
      avatar: params.avatar,
    );
  }
}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams({
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const CreateUserParams.empty()
      : this(
          createdAt: "empty.CreatedAt",
          name: "empty.name",
          avatar: "empty.avatar",
        );

  @override
  List<Object?> get props => [createdAt, name, avatar];
}
