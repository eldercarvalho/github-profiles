import 'package:equatable/equatable.dart';

class RepoEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final int stargazersCount;
  final int watchersCount;
  final String language;
  final int forkCount;
  final String? homepage;

  const RepoEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.stargazersCount,
    required this.watchersCount,
    required this.language,
    required this.forkCount,
    this.homepage,
  });

  bool get hasHomepage => homepage != null;

  @override
  List<Object?> get props => [id, name];
}
