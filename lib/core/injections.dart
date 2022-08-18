import 'package:get_it/get_it.dart';
import 'package:github_profiles/pages/home/cubit/home_cubit.dart';
import 'package:github_profiles/repositories/users/user_repository.dart';
import 'package:github_profiles/repositories/users/user_repository_impl.dart';
import 'package:github_profiles/services/contacts/contacts_service.dart';
import 'package:github_profiles/services/contacts/contacts_service_impl.dart';
import 'package:github_profiles/services/github_api/github_api.dart';
import 'package:github_profiles/services/github_api/github_api_impl.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(
    () => HomeCubit(
      userRepository: getIt(),
      contactsService: getIt(),
    ),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      gitHubApi: getIt(),
    ),
  );

  getIt.registerLazySingleton<GitHubApi>(
    () => GitHubApiImpl(),
  );

  getIt.registerLazySingleton<ContactsService>(
    () => ContactsServiceImpl(),
  );
}
