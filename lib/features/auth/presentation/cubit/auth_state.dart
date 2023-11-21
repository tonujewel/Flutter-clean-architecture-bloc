part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class CreatingUserState extends AuthState {
  const CreatingUserState();
}

class GettingUsersState extends AuthState {
  const GettingUsersState();
}

class UserCreatedState extends AuthState {
  const UserCreatedState();
}

class UserLoadedState extends AuthState {
  const UserLoadedState(this.users);

  final List<UserData> users;

  @override
  List<Object> get props => users.map((e) => e.id).toList();
}

class AutheticationErrorState extends AuthState {
  const AutheticationErrorState({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}