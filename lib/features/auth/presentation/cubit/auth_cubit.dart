import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_data.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/get_users.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser(
      {required String createdAt, required String name, required String avatar}) async {
    emit(const CreatingUserState());
    final result = await _createUser(CreateUserParams(
      createdAt: createdAt,
      name: name,
      avatar: avatar,
    ));

    result.fold(
      (l) => emit(AutheticationErrorState(message: "${l.statusCode} ${l.message}")),
      (r) => emit(const UserCreatedState()),
    );
  }

  Future<void> getUsers() async {
    emit(const GettingUsersState());
    final result = await _getUsers();

    result.fold(
      (l) => emit(AutheticationErrorState(message: l.message)),
      (r) => emit(UserLoadedState(r)),
    );
  }
}
