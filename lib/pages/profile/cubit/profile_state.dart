import 'package:equatable/equatable.dart';

import 'package:github_profiles/core/core.dart';
import 'package:github_profiles/entities/user_entity.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final UserEntity user;

  ProfileSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

class ProfileLoadingState extends ProfileState {}

class ProfileFailureState extends ProfileState {
  final Failure failure;

  ProfileFailureState({required this.failure});

  @override
  List<Object?> get props => [failure];
}
