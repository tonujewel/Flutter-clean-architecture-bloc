part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthEvent {
  final String createdAt, name, avatar;

  const CreateUserEvent({required this.createdAt, required this.name, required this.avatar});

  @override
  List<Object> get props => [createdAt, name, avatar];
}

class GetUserEvent extends AuthEvent {
  const GetUserEvent();
}
