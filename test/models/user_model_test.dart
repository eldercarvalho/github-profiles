import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:github_profiles/entities/user_entity.dart';
import 'package:github_profiles/models/user_model.dart';

import '../fixtures/fixtures_reader.dart';

void main() {
  const userModel = UserModel(
    login: "eldercarvalho",
    id: 6839555,
    avatarUrl: "https://avatars.githubusercontent.com/u/6839555?v=4",
    publicRepos: 27,
    followers: 14,
    following: 7,
    createdAt: "2014-03-03T12:32:56Z",
    bio: "ront-end & Mobile  Developer",
    blog: "",
    location: "Florianópolis, SC",
    company: "Sasi Comunicação Ágil",
    name: "Elder Carvalho",
  );

  final userJson = jsonDecode(fixture('user.json'));

  group('UserModel |', () {
    test('shoud be a subclass of UserEntity', () {
      expect(userModel, isA<UserEntity>());
    });

    group('fromJson |', () {
      test('should return a instance of RepoModel', () {
        final result = UserModel.fromJson(userJson);

        expect(result, isA<UserModel>());
        expect(result, userModel);
      });
    });
  });
}
