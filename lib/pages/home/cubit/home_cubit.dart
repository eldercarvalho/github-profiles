import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profiles/repositories/users/user_repository.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserRepository userRepository;

  HomeCubit(this.userRepository) : super(HomeInitialState());

  void fetchUsers() async {
    emit(HomeLoadingState());
    final usersEither = await userRepository.getUsers();

    usersEither.fold(
      (failure) => emit(HomeFailureState()),
      (users) => emit(HomeSuccessState(users: users)),
    );
  }

  void fetchUserInfo(String userLoginId) async {
    emit(HomeLoadingState());
    final userEither = await userRepository.getUserInfo(userLoginId);

    userEither.fold(
      (failure) => emit(HomeFailureState()),
      (user) => emit(HomeSearchSuccessState(user: user)),
    );
  }
}
