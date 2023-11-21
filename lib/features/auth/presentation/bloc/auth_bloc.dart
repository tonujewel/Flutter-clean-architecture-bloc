import '../../domain/entities/user_data.dart';
import '../../domain/usecases/create_user.dart';
import '../../domain/usecases/get_users.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(CreateUserEvent event, Emitter<AuthState> emit) async {
    emit(const CreatingUserState());
    final result = await _createUser(CreateUserParams(
      createdAt: event.createdAt,
      name: event.name,
      avatar: event.avatar,
    ));

    result.fold(
      (l) => emit(AutheticationErrorState(message: "${l.statusCode} ${l.message}")),
      (r) => emit(const UserCreatedState()),
    );
  }

  Future<void> _getUsersHandler(GetUserEvent event, Emitter<AuthState> emit) async {
    emit(const GettingUsersState());
    final result = await _getUsers();

    result.fold(
      (l) => emit(AutheticationErrorState(message: l.message)),
      (r) => emit(UserLoadedState(r)),
    );
  }
}
