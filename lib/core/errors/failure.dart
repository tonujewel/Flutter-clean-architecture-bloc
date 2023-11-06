import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String statusCode;

  const Failure({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, required super.statusCode});
}
