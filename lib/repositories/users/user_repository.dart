import 'package:dartz/dartz.dart';

import 'package:github_profiles/core/error/error.dart';
import 'package:github_profiles/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();
  Future<Either<Failure, UserEntity>> getUserInfo(String userLoginId);
}
