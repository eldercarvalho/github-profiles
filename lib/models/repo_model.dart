import 'package:github_profiles/entities/repo_entity.dart';

class RepoModel extends RepoEntity {
  const RepoModel({
    required super.id,
    required super.name,
    required super.description,
    required super.stargazersCount,
    required super.watchersCount,
    required super.language,
    required super.forkCount,
    super.homepage,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      stargazersCount: json["stargazers_count"],
      watchersCount: json["watchers_count"],
      language: json["language"],
      forkCount: json["fork_count"],
      homepage: json["homepage"],
    );
  }

  @override
  List<Object?> get props => [id, name];
}
