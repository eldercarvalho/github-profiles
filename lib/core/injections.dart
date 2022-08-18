import 'package:get_it/get_it.dart';
import 'package:github_profiles/pages/home/cubit/home_cubit.dart';
import 'package:github_profiles/repositories/users/users_repository.dart';
import 'package:github_profiles/repositories/users/users_repository_impl.dart';
import 'package:github_profiles/services/github_api/github_api.dart';
import 'package:github_profiles/services/github_api/github_api_impl.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => HomeCubit(getIt()));

  getIt.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(gitHubApi: getIt()),
  );

  getIt.registerLazySingleton<GitHubApi>(() => GitHubApiImpl());
}
