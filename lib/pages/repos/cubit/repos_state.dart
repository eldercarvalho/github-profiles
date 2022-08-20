import 'package:equatable/equatable.dart';

import 'package:github_profiles/core/core.dart';
import 'package:github_profiles/entities/repo_entity.dart';

abstract class ReposState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends ReposState {}

class SuccessState extends ReposState {
  final List<RepoEntity> repos;

  SuccessState({required this.repos});

  @override
  List<Object?> get props => [repos];
}

class LoadingState extends ReposState {}

class FailureState extends ReposState {
  final Failure failure;

  FailureState({required this.failure});

  @override
  List<Object?> get props => [failure];
}
