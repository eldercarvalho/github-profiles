import 'package:dartz/dartz.dart';

import 'package:github_profiles/entities/repo_entity.dart';
import 'package:github_profiles/core/error/error.dart';
import 'package:github_profiles/models/models.dart';
import 'package:github_profiles/repositories/base_repository.dart';
import 'package:github_profiles/services/services.dart';

import 'repo_repository.dart';

class RepoRepositoryImpl extends BaseRepository implements RepoRepository {
  final GitHubApi gitHubApi;


  RepoRepositoryImpl({
    required this.gitHubApi,
    required ConnectionService connectionService,
  }) : super(connectionService);

  @override
  Future<Either<Failure, List<RepoEntity>>> getReposByUserLogin(
    String userLoginId,
  ) {
    return handleErrors(() async {
      final result = await gitHubApi.getUserRepositories(userLoginId);
      return List.from(result).map((user) => RepoModel.fromJson(user)).toList();
    });
  }
}
