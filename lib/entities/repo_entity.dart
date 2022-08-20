import 'package:equatable/equatable.dart';

class RepoEntity extends Equatable {
  final int id;
  final String name;
  final String? description;
  final int stargazersCount;
  final int watchersCount;
  final String? language;
  final int forksCount;
  final String? homepage;

  const RepoEntity({
    required this.id,
    required this.name,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    this.description,
    this.language,
    this.homepage,
  });

  bool get hasDescription => description != null;

  bool get hasHomepage => homepage != null && homepage!.isNotEmpty;

  bool get hasLanguage => language != null;

  @override
  List<Object?> get props => [id, name];
}
