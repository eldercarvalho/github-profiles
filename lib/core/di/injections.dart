import 'package:get_it/get_it.dart';
import 'package:github_profiles/pages/pages.dart';
import 'package:github_profiles/repositories/repositories.dart';
import 'package:github_profiles/services/connection/connection.dart';
import 'package:github_profiles/services/contacts/contacts_service.dart';
import 'package:github_profiles/services/contacts/contacts_service_impl.dart';
import 'package:github_profiles/services/github/github.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Cubits
  getIt.registerFactory(
    () => HomeCubit(
      userRepository: getIt(),
      contactsService: getIt(),
    ),
  );

  getIt.registerFactory(
    () => ProfileCubit(
      userRepository: getIt(),
    ),
  );

  getIt.registerFactory(
    () => ReposCubit(
      repoRepository: getIt(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      gitHubApi: getIt(),
      connectionService: getIt(),
    ),
  );

  getIt.registerLazySingleton<RepoRepository>(
    () => RepoRepositoryImpl(
      gitHubApi: getIt(),
      connectionService: getIt(),
    ),
  );

  // Services
  getIt.registerLazySingleton<GitHubApi>(
    () => GitHubApiImpl(),
  );

  getIt.registerLazySingleton<ContactsService>(
    () => ContactsServiceImpl(),
  );

  getIt.registerLazySingleton<ConnectionService>(
    () => ConnectionServiceImpl(),
  );
}
