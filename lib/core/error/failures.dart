import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final int statusCode;

  ServerFailure({this.statusCode = 500});

  bool get isUnauthorized => statusCode == 401;
  bool get isNotFound => statusCode == 404;
  bool get isUnprocessableEntity => statusCode == 422;
  bool get isServerError => statusCode == 500;
}

class NoConnectionFailure extends Failure {}
