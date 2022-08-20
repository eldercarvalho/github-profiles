import 'package:dartz/dartz.dart';

import 'package:github_profiles/core/core.dart';
import 'package:github_profiles/services/services.dart';

abstract class BaseRepository {
  final ConnectionService connectionService;

  BaseRepository(this.connectionService);

  Future<Either<Failure, T>> handleErrors<T>(
    Future<T> Function() callback,
  ) async {
    try {
      final hasConnection = await connectionService.checkConnection();

      if (!hasConnection) {
        throw const NotConnectionException();
      }

      return right(await callback());
    } catch (err) {
      return left(Failure.parseExceptionToFailure(err));
    }
  }
}
