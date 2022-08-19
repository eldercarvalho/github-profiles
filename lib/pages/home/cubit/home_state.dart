import 'package:equatable/equatable.dart';

import 'package:github_profiles/core/core.dart';
import 'package:github_profiles/entities/user_entity.dart';
import 'package:github_profiles/services/contacts/contacts_service.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<UserEntity> users;

  HomeSuccessState({required this.users});
}

class HomeLoadingState extends HomeState {}

class HomeFailureState extends HomeState {
  final Failure failure;

  HomeFailureState({required this.failure});
}

class HomeContactsState extends HomeState {
  final List<AppContact>? contacts;

  HomeContactsState({this.contacts});
}
