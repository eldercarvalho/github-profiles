import 'package:dartz/dartz.dart';
import 'package:github_profiles/entities/user_entity.dart';

abstract class UsersRepository {
  Future<Either<Error, List<UserEntity>>> getUsers();
}
