import 'package:dartz/dartz.dart';
import 'package:github_profiles/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Error, List<UserEntity>>> getUsers();
}
