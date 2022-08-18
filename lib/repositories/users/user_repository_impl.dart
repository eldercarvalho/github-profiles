import 'package:dartz/dartz.dart';

import 'package:github_profiles/models/user_model.dart';
import 'package:github_profiles/entities/user_entity.dart';
import 'package:github_profiles/services/github_api/github_api.dart';

import 'user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final GitHubApi gitHubApi;

  UserRepositoryImpl({required this.gitHubApi});

  @override
  Future<Either<Error, List<UserEntity>>> getUsers() async {
    try {
      final result = await gitHubApi.getRandomUsers();
      final usersList =
          List.from(result).map((user) => UserModel.fromJson(user)).toList();
      return right(usersList);
    } catch (err) {
      print(err);
      return left(Error());
    }
  }
}
