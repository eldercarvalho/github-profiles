import 'package:equatable/equatable.dart';

import 'exceptions.dart';

abstract class Failure extends Equatable {
  static Failure parseExceptionToFailure(Object exception) {
    if (exception is Exception) {
      if (exception is NotFoundException) {
        return ServerFailure(statusCode: 404);
      }

      if (exception is ServerException) {
        return ServerFailure();
      }

      if (exception is NotConnectionException) {
        return NoConnectionFailure();
      }

      return AppFailure();
    }

    return AppFailure();
  }

  @override
  List<Object?> get props => [];
}

class AppFailure extends Failure {}

class ServerFailure extends Failure {
  final int statusCode;

  ServerFailure({this.statusCode = 500});

  bool get isUnauthorized => statusCode == 401;
  bool get isNotFound => statusCode == 404;
  bool get isUnprocessableEntity => statusCode == 422;
  bool get isServerError => statusCode == 500;
}

class NoConnectionFailure extends Failure {}
