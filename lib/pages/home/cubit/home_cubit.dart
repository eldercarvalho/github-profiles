import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profiles/repositories/users/user_repository.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserRepository usersRepository;

  HomeCubit(this.usersRepository) : super(HomeInitialState());

  void fetchUsers() async {
    final usersEither = await usersRepository.getUsers();

    usersEither.fold(
      (failure) => emit(HomeFailureState()),
      (users) => emit(HomeSuccessState(users: users)),
    );
  }
}
