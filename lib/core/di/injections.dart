import 'package:get_it/get_it.dart';
import 'package:github_profiles/pages/home/cubit/home_cubit.dart';
import 'package:github_profiles/pages/profile/cubit/profile_cubit.dart';
import 'package:github_profiles/repositories/users/user_repository.dart';
import 'package:github_profiles/repositories/users/user_repository_impl.dart';
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

  // Repositories
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
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
