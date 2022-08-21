import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_profiles/entities/repo_entity.dart';
import 'package:github_profiles/models/repo_model.dart';

import '../fixtures/fixtures_reader.dart';

void main() {
  const repoModel = RepoModel(
    id: 510172891,
    name: 'amplifyapp',
    stargazersCount: 0,
    watchersCount: 0,
    forksCount: 0,
    description: 'Amplify Console CI/CD Demo',
    homepage: null,
    language: 'TypeScript',
  );

  final repoJson = jsonDecode(fixture('repo.json'));

  group('RepoModel |', () {
    test('shoud be a subclass of RepoEntity', () {
      expect(repoModel, isA<RepoEntity>());
    });

    group('fromJson |', () {
      test('should return a instance of RepoModel', () {
        final result = RepoModel.fromJson(repoJson);

        expect(result, isA<RepoModel>());
        expect(result, repoModel);
      });
    });
  });
}
