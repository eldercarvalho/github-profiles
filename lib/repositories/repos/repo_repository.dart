import 'package:dartz/dartz.dart';

import 'package:github_profiles/core/error/failures.dart';
import 'package:github_profiles/entities/repo_entity.dart';

abstract class RepoRepository {
  Future<Either<Failure, List<RepoEntity>>> getReposByUserLogin(
    String userLoginId,
  );
}
