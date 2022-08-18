import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profiles/repositories/users/users_repository.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UsersRepository usersRepository;

  HomeCubit(super.initialState, this.usersRepository);

  void fetchUsers() async {
    final usersEither = await usersRepository.getUsers();

    usersEither.fold(
      (failure) => null,
      (users) => emit(HomeSuccessState(users: users)),
    );
  }
}
