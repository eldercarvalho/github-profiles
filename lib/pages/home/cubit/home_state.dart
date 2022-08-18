import 'package:equatable/equatable.dart';
import 'package:github_profiles/entities/user_entity.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<UserEntity> users;

  HomeSuccessState({required this.users});
}

class HomeSearchSuccessState extends HomeState {
  final UserEntity user;

  HomeSearchSuccessState({required this.user});
}

class HomeLoadingState extends HomeState {}

class HomeFailureState extends HomeState {}
