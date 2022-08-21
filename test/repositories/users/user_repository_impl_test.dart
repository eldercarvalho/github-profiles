import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_profiles/entities/user_entity.dart';
import 'package:github_profiles/models/models.dart';
import 'package:github_profiles/repositories/users/users.dart';
import 'package:github_profiles/services/services.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixtures_reader.dart';

class MockGithubApi extends Mock implements GitHubApi {}

class MockConnectionService extends Mock implements ConnectionService {}

void main() {
  late MockGithubApi mockGithubApi;
  late MockConnectionService mockConnectionService;
  late UserRepository repository;

  setUp(() {
    mockGithubApi = MockGithubApi();
    mockConnectionService = MockConnectionService();
    repository = UserRepositoryImpl(
      gitHubApi: mockGithubApi,
      connectionService: mockConnectionService,
    );
  });

  group("UserRepository |", () {
    List usersJson = jsonDecode(fixture('users_list.json'));
    final usersListJson = List<Map<String, dynamic>>.from(usersJson).toList();
    final List<UserEntity> usersList = List.from(usersListJson)
        .map((user) => UserModel.fromJson(user))
        .toList();

    group("getUsers |", () {
      test(
          'should return a list of [UserEntity] if the call to api is successful',
          () async {
        when(() => mockConnectionService.checkConnection())
            .thenAnswer((invocation) async => true);
        when(() => mockGithubApi.getRandomUsers())
            .thenAnswer((invocation) async => usersListJson);

        final result = await repository.getUsers();

        result.fold(
          (failure) => null,
          (users) {
            expect(users, equals(usersList));
            verify(() => mockConnectionService.checkConnection()).called(1);
            verify(() => mockGithubApi.getRandomUsers()).called(1);
          },
        );
      });
    });
  });
}
