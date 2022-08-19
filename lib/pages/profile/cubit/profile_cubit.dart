import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:github_profiles/repositories/users/user_repository.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository userRepository;

  ProfileCubit({required this.userRepository}) : super(ProfileInitialState());

  void fetchUserInfo(String userLoginId) async {
    emit(ProfileLoadingState());
    final userEither = await userRepository.getUserInfo(userLoginId);

    userEither.fold(
      (failure) => emit(ProfileFailureState(failure: failure)),
      (user) => emit(ProfileSuccessState(user: user)),
    );
  }
}
