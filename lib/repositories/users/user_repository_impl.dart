import 'package:dartz/dartz.dart';
import 'package:github_profiles/core/error/error.dart';

import 'package:github_profiles/models/user_model.dart';
import 'package:github_profiles/entities/user_entity.dart';
import 'package:github_profiles/services/connection/connection.dart';
import 'package:github_profiles/services/github/github.dart';

import 'user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final GitHubApi gitHubApi;
  final ConnectionService connectionService;

  UserRepositoryImpl({
    required this.gitHubApi,
    required this.connectionService,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    return _fetch<List<UserEntity>>(() async {
      final result = await gitHubApi.getRandomUsers();
      return List.from(result).map((user) => UserModel.fromJson(user)).toList();
    });
  }

  @override
  Future<Either<Failure, UserEntity>> getUserInfo(String userLoginId) async {
    return _fetch<UserEntity>(() async {
      final result = await gitHubApi.getUserInformation(userLoginId);
      return UserModel.fromJson(result);
    });
  }

  Future<Either<Failure, T>> _fetch<T>(Future<T> Function() callback) async {
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
